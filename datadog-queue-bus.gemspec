# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'datadog_queue_bus/version'

Gem::Specification.new do |spec|
  spec.name          = 'datadog-queue-bus'
  spec.version       = DatadogQueueBus::VERSION
  spec.authors       = ['kbacha']
  spec.email         = ['chewbacha@gmail.com']

  spec.summary       = 'A Datadog APM integration for queue-bus'
  spec.description   = <<-DESC.gsub(/^\s+/, '')
    A Datadog APM integration for queue-bus

    Through the use of installing a middleware for queue-bus, this gem
    will initiate a span for Datadog around every execution of the
    QueueBus::Worker.
  DESC
  spec.homepage      = 'https://github.com/queue-bus/datadog-queue-bus'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.require_paths = ['lib']

  spec.add_dependency 'datadog', '~> 2.0'
  spec.add_dependency 'queue-bus', '~> 0.6'

  spec.add_development_dependency 'bundler', '~> 2.4'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.72'
end
