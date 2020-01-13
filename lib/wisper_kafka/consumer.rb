# frozen_string_literal: true

require 'racecar'
require 'json'
require 'active_support/core_ext/hash/keys'

module WisperKafka
  class Consumer < Racecar::Consumer
    subscribes_to WisperKafka::Settings.topic

    # :reek:UtilityFunction
    def process(message)
      parsed_message = JSON.parse(message.value).deep_symbolize_keys

      subscriber = parsed_message.fetch(:subscriber)
      event = parsed_message.fetch(:event)
      args = parsed_message.fetch(:args)

      Object.const_get(subscriber).public_send(event, *args)
    end
  end
end
