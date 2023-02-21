# frozen_string_literal: true

module DatadogQueueBus
  # Use this middleware with queue-bus to start recording spans everytime the queue-bus performs
  # work on the server.
  class Middleware < QueueBus::Middleware::Abstract
    def call(attrs)
      class_proxy = attrs['bus_class_proxy']
      event_type = attrs['bus_event_type']
      sub_key = attrs['bus_rider_sub_key']

      resource = class_proxy
      resource += " event=#{event_type}" if event_type
      resource += " sub=#{sub_key}" if sub_key

      # def trace(name, continue_from: nil, **span_options, &block)
      Datadog::Tracing.trace('queue-bus.worker',
                             service: DatadogQueueBus.service_name,
                             resource: resource) do |span|
        attrs.keys.grep(/^bus_/).each do |key|
          span.set_tag("queue-bus.#{key}", attrs[key])
        end
        @app.call
      end
    end
  end
end
