# frozen_string_literal: true

require 'racecar'
require 'json'

module WisperKafka
  class Consumer < Racecar::Consumer
    subscribes_to WisperKafka::Settings.topic

    # :reek:UtilityFunction
    def process(message)
      parsed_message = JSON.parse(message.value, symbolize_names: true)

      subscriber = parsed_message.fetch(:subscriber)
      event = parsed_message.fetch(:event)
      args = parsed_message.fetch(:args)

      Object.const_get(subscriber).public_send(event, *args)
    end
  end
end
