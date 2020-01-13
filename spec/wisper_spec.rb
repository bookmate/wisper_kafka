# frozen_string_literal: true

RSpec.describe Wisper do
  let(:configuration) { described_class.configuration }

  it 'configures kafka as a broadcaster' do
    expect(configuration.broadcasters).to include(:kafka)
  end
end
