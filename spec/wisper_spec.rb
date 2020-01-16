# frozen_string_literal: true

RSpec.describe Wisper do
  let(:configuration) { described_class.configuration }

  it 'configures kafka as a broadcaster' do
    expect(configuration.broadcasters.fetch(:kafka)).to be_an_instance_of(WisperKafka::Broadcaster)
  end
end
