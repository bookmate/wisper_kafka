# frozen_string_literal: true

module WisperKafka
  module Settings
    module_function

    DEFAULT_TOPIC = 'wisper_events'

    def topic
      @topic || DEFAULT_TOPIC
    end

    def topic=(topic)
      @topic = topic
    end
  end
end
