require 'spec_helper'

Sensor.require("twitter_retrieval")

describe Sensor::Actuator::TwitterRetrieval, :vcr do
  it 'fetches relevant stats' do
    date_range = Sensor::TimeRange.new('yesterday', 'today')
    act = Sensor::Actuator::TwitterRetrieval.new(date_range)
    results = act.acquire
    expect(results).to_not be_nil
    expect(results[:twitter]).to_not be_nil
    expect(results[:twitter][:followers]).to_not be_nil
    expect(results[:twitter][:tweets]).to_not be_nil
    expect(results[:twitter][:mentions]).to_not be_nil
  end
end
