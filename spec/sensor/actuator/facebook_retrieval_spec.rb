require 'spec_helper'

Sensor.require("facebook_retrieval")

describe Sensor::Actuator::FacebookRetrieval, :vcr do
  it 'fetches relevant stats' do
    date_range = Sensor::TimeRange.new('yesterday', 'today')
    act = Sensor::Actuator::FacebookRetrieval.new(date_range)
    results = act.acquire
    expect(results).to_not be_nil
    expect(results[:facebook]).to_not be_nil
    expect(results[:facebook][:likes]).to_not be_nil
  end
end
