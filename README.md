# WisperKafka

Asynchronous event publishing for Wisper using Kafka.

[![Gem Version](https://badge.fury.io/rb/wisper_kafka.svg)](https://badge.fury.io/rb/wisper_kafka)
[![Build Status](https://travis-ci.org/bookmate/wisper_kafka.svg?branch=master)](https://travis-ci.org/bookmate/wisper_kafka)
[![Maintainability](https://api.codeclimate.com/v1/badges/6d7aa78830602cc3f891/maintainability)](https://codeclimate.com/github/bookmate/wisper_kafka/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/6d7aa78830602cc3f891/test_coverage)](https://codeclimate.com/github/bookmate/wisper_kafka/test_coverage)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wisper_kafka'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wisper_kafka

## Usage

### Configure DeliveryBoy
https://github.com/zendesk/delivery_boy#configuration

### Configure Racecar
https://github.com/zendesk/racecar#installation

### Use WisperKafka

Set `broadcaster` as `:kafka`:

```ruby
Wisper.subscribe(Subscriber, broadcaster: :kafka)
```

### Setup topic for events
Default topic is: `wisper_events`.

You can set it manually:
```
WisperKafka::Settings.topic = 'custom_topic'
```

### Custom topic and other DeliveryBoy params.
Default params: 
```ruby
{ topic: WisperKafka::Settings.topic }
```

You can use your own `kafka_options` into subscriber.
```ruby
class Subscriber
  def self.kafka_options(event_id:)
    partition_key = "event-#{event_id}"
    { topic: 'custom_topic', partition_key: partition_key }
  end

  def self.new_event(event_id:); end
end
```

### Consumers
You can write [your own consumer](https://github.com/zendesk/racecar#running-consumers), or use default [WisperKafka::Consumer](https://github.com/bookmate/wisper_kafka/blob/master/lib/wisper_kafka/consumer.rb).

[Run your consumer](https://github.com/zendesk/racecar#running-consumers)

## Development

After checking out the repo, run `bin/setup` to install dependencies.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Test
Run `rake spec` to run the tests. 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bookmate/wisper_kafka.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
