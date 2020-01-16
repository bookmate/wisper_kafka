# frozen_string_literal: true

RSpec.describe WisperKafka::Consumer do
  describe '#process' do
    subject(:process) { described_class.new.process(message) }

    let(:subscriber_class) do
      Class.new do
        # :reek:UnusedParameters
        def self.new_event(event_id:); end
      end
    end
    let(:args) { { event_id: 1 } }
    let(:event_data) do
      { subscriber: Subscriber, event: :new_event, args: [args] }
    end
    let(:message) { instance_double('Racecar::Message', value: event_data.to_json) }

    before do
      stub_const('Subscriber', subscriber_class)
      allow(Subscriber).to receive(:new_event)
    end

    it 'calls subscriber component with correct args' do
      process

      expect(Subscriber).to have_received(:new_event).with(**args)
    end
  end
end
