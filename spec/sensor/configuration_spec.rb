require 'spec_helper'

describe Sensor::Configuration do
  let(:config) { Sensor::Configuration.new }
  let(:actuator) { Sensor::Actuator::TwitterRetrieval }
  it 'appends actuators' do
    config.append_actuator(actuator)
    expect(config.actuators).to include(actuator)
  end

  it 'appends actuators only once' do
    config.actuators = []
    2.times { config.append_actuator(actuator) }
    expect(config.actuators).to include(actuator)
    expect(config.actuators.size).to eql(1)
  end
end
