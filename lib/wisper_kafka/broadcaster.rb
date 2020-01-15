# frozen_string_literal: true

require 'wisper'
# TODO: remove next line when ruby-kafka version will be > 0.7.10
# 'cause this bug https://github.com/zendesk/ruby-kafka/pull/768 still reproduced
require 'delegate'
require 'delivery_boy'

module WisperKafka
  class Broadcaster
    def self.register
      Wisper.configure do |config|
        config.broadcaster :kafka, new
      end
    end

    # :reek:ManualDispatch
    def self.kafka_options(subscriber, args)
      return subscriber.kafka_options(*args) if subscriber.respond_to?(:kafka_options)

      { topic: WisperKafka::Settings.topic }
    end

    # :reek:LongParameterList
    # :reek:UtilityFunction
    def broadcast(subscriber, _publisher, event, args)
      event_data = { subscriber: subscriber, event: event, args: args }
      kafka_options = self.class.kafka_options(subscriber, args)

      DeliveryBoy.deliver(event_data.to_json, **kafka_options)
    end
  end
end

WisperKafka::Broadcaster.register
