# frozen_string_literal: true

RSpec.describe WisperKafka::Settings do
  before { described_class.topic = nil }

  describe '.topic' do
    subject(:topic) { described_class.topic }

    it 'returns default topic' do
      expect(topic).to eq(described_class::DEFAULT_TOPIC)
    end
  end

  describe '.topic=' do
    subject(:set_topic) { described_class.topic = expected_topic }

    let(:expected_topic) { 'custom_topic' }

    after { described_class.topic = nil }

    it 'returns set value' do
      expect { set_topic }.
        to change(described_class, :topic).from(described_class::DEFAULT_TOPIC).to(expected_topic)
    end
  end
end
