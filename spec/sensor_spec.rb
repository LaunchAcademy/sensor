require 'spec_helper'

Sensor.require("twitter_retrieval")
Sensor.require("facebook_retrieval")
Sensor.require("flow_dock")

describe Sensor do
  before do
    @old_config = Sensor.configuration
  end

  after do
    Sensor.configuration = @old_config
  end

  it 'allows me to set desired actuators' do
    Sensor.configure do |config|
      config.actuators = [
        Sensor::Actuator::TwitterRetrieval,
        Sensor::Actuator::FacebookRetrieval
      ]
    end
  end

  it 'defaults to the whole collection' do
    Sensor.configure do |config|
    end

    expect(Sensor.configuration.actuators.size).to_not eql(0)
  end
end
