require 'spec_helper'

Sensor.require("analytics_retrieval")

describe Sensor::Actuator::AnalyticsRetrieval, vcr: true do
  it 'returns the count of visits' do
    Timecop.freeze(Chronic.parse('01/01/13')) do
      date_range = Sensor::TimeRange.new('yesterday', 'today')
      act = Sensor::Actuator::AnalyticsRetrieval.new(date_range)
      results = act.acquire
      expect(results).to_not be_nil
      expect(results[:analytics]).to_not be_nil
      expect(results[:analytics][:visitors]).to_not be_nil
    end
  end
end
