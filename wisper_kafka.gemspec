# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wisper_kafka/version'

Gem::Specification.new do |spec|
  spec.name          = 'wisper_kafka'
  spec.version       = WisperKafka::VERSION
  spec.authors       = ['Pavel Rodionov']
  spec.email         = ['pasha.rod@mail.ru']

  spec.summary       = 'Asynchronous event publishing for Wisper using Kafka'
  spec.description   = 'Asynchronous event publishing for Wisper using Kafka'
  spec.homepage      = 'https://github.com/bookmate/wisper_kafka'
  spec.license       = 'MIT'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/bookmate/wisper_kafka'
  spec.metadata['changelog_uri'] = 'https://github.com/bookmate/wisper_kafka/blob/master/CHANGELOG.md'

  spec.files         = Dir.glob('lib/**/*') + Dir.glob('bin/*')
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'delivery_boy'
  spec.add_dependency 'racecar'
  spec.add_dependency 'wisper'

  spec.add_development_dependency 'bundler', '>= 1.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'reek', '~> 5.5.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.78.0'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.37'
  spec.add_development_dependency 'simplecov', '~> 0.17.1'
end
