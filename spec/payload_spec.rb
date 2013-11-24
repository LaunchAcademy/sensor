require 'spec_helper'

describe Sensor::Payload, :vcr do

  it 'fetches relevant data' do
    date_range = Sensor::TimeRange.new('yesterday', 'today')
    act = Sensor::Payload.new(date_range)
    results = act.acquire
    expect(results).to_not be_nil

    act.distribute
  end
end
