# frozen_string_literal: true

require 'spec_helper'

RSpec.describe DatadogQueueBus do
  it 'has a version number' do
    expect(DatadogQueueBus::VERSION).not_to be nil
  end

  describe '.service_name' do
    let(:name) { rand.to_s }

    it 'sets the name' do
      expect { DatadogQueueBus.service_name = name }
        .to change(DatadogQueueBus, :service_name)
        .from('queue-bus').to(name)
    end
  end
end
