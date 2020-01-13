# frozen_string_literal: true

RSpec.describe WisperKafka::Broadcaster do
  describe '#broadcast' do
    let(:subscriber_class) do
      Class.new do
        # :reek:UnusedParameters
        def self.new_event(event_id:); end
      end
    end
    let(:publisher_class) do
      Class.new do
        include Wisper::Publisher

        def call
          broadcast(:new_event, event_id: 1)
        end
      end
    end

    let(:publisher) { Publisher.new }
    let(:expected_event_data) do
      { subscriber: Subscriber, event: :new_event, args: [{ event_id: 1 }] }
    end

    before do
      stub_const('Publisher', publisher_class)
      stub_const('Subscriber', subscriber_class)
      allow(DeliveryBoy).to receive(:deliver)
      Wisper.subscribe(Subscriber, broadcaster: :kafka)
    end

    it 'emits an event with kafka broadcaster' do
      publisher.call

      expect(DeliveryBoy).to have_received(:deliver).with(
        expected_event_data.to_json, topic: WisperKafka::Settings.topic
      )
    end

    context 'when subscriber has his own kafka_options' do
      let(:subscriber_class) do
        Class.new do
          # :reek:UnusedParameters
          def self.new_event(event_id:); end

          def self.kafka_options(args)
            partition_key = "event-#{args.fetch(:event_id)}"
            { topic: 'custom_topic', partition_key: partition_key }
          end
        end
      end

      it 'emits an event with kafka broadcaster and custom kafka options' do
        publisher.call

        expect(DeliveryBoy).to have_received(:deliver).with(
          expected_event_data.to_json, topic: 'custom_topic', partition_key: 'event-1'
        )
      end
    end
  end
end
