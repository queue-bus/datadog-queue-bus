# frozen_string_literal: true

require 'spec_helper'

RSpec.describe DatadogQueueBus::Middleware do
  subject { described_class.new(app) }

  let(:app) { spy('app', call: true) }
  let(:attrs) do
    {
      'bus_class_proxy' => 'QueueBus::Driver'
    }
  end
  let(:tracer) { Datadog::Tracing }

  it 'uses the class_proxy_class as the resource name' do
    expect(tracer)
      .to receive(:trace)
      .with('queue-bus.worker', hash_including(resource: 'QueueBus::Driver'))
    subject.call(attrs)
  end

  context 'with a service name' do
    let(:name) { rand.to_s }

    before do
      DatadogQueueBus.service_name = name
    end

    it 'sends the service name' do
      expect(tracer)
        .to receive(:trace)
        .with('queue-bus.worker', hash_including(service: name))
      subject.call(attrs)
    end
  end

  context 'with an event type' do
    let(:attrs) do
      super().merge('bus_event_type' => 'my_event')
    end

    it 'includes the event in the resource' do
      expect(tracer)
        .to receive(:trace)
        .with('queue-bus.worker',
              hash_including(resource: a_string_matching(/event=my_event/)))
      subject.call(attrs)
    end
  end

  context 'with a rider subscriber key' do
    let(:attrs) do
      super().merge('bus_rider_sub_key' => 'my_subscription')
    end

    it 'includes the sub key in the resource name' do
      expect(tracer)
        .to receive(:trace)
        .with('queue-bus.worker',
              hash_including(resource: a_string_matching(/sub=my_subscription/)))
      subject.call(attrs)
    end
  end

  context 'with additional bus fields' do
    let(:attrs) do
      super().merge('bus_field' => 'my_field')
    end

    it 'includes all attributes that start with bus_' do
      span = spy('span')
      expect(tracer).to receive(:trace).and_yield(span)
      subject.call(attrs)
      expect(span).to have_received(:set_tag).with('queue-bus.bus_class_proxy', 'QueueBus::Driver')
      expect(span).to have_received(:set_tag).with('queue-bus.bus_field', 'my_field')
    end
  end

  context 'with additional non-bus fields' do
    let(:attrs) do
      super().merge('user_id' => 1234, 'other_field' => 'blah')
    end

    it 'includes all attributes that start with bus_' do
      span = spy('span')
      expect(tracer).to receive(:trace).and_yield(span)
      subject.call(attrs)
      expect(span).to have_received(:set_tag).with('queue-bus.bus_class_proxy', 'QueueBus::Driver')
      expect(span).not_to have_received(:set_tag).with('queue-bus.user_id', 1234)
      expect(span).not_to have_received(:set_tag).with('queue-bus.other_field', 'blah')
    end
  end
end
