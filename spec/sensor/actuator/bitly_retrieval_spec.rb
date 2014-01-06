require 'spec_helper'

Sensor.require("bitly_retrieval")

describe Sensor::Actuator::BitlyRetrieval, :vcr do
  it 'fetches relevant stats' do
    date_range = Sensor::TimeRange.new('yesterday', 'today')
    act = Sensor::Actuator::BitlyRetrieval.new(date_range)
    results = act.acquire
    expect(results[:links]).to_not be_nil
    expect(results[:clicks]).to_not be_nil
  end
end
