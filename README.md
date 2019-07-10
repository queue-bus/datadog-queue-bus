# DatadogQueueBus

A concrete middleware implementation for queue-bus that adds spans around work done within the queue-bus.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'datadog_queue_bus'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install datadog_queue_bus

## Usage

To set up the middleware simply add it to the queue-bus:

```ruby
QueueBus.worker_middleware_stack.use DatadogQueueBus::Middleware
```

To override the default service name (which will be `queue-bus` if not set):

```ruby
DatadogQueueBus.service_name = 'my-queue-bus-service'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/datadog_queue_bus. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DatadogQueueBus project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/datadog_queue_bus/blob/master/CODE_OF_CONDUCT.md).
