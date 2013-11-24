Sensor.require("analytics_retrieval")
Sensor.require("twitter_retrieval")
Sensor.require("facebook_retrieval")
Sensor.require("flow_dock")

module Sensor
  class Payload
    attr_reader :data, :time_range
    delegate :start_date, to: :time_range
    delegate :end_date, to: :time_range

    def initialize(time_range)
      @time_range = time_range
      @data = {}
    end

    def acquire
      [
        Sensor::Actuator::AnalyticsRetrieval,
        Sensor::Actuator::TwitterRetrieval,
        Sensor::Actuator::FacebookRetrieval
      ].each do |actuator|
        @data.merge!(actuator.new(@time_range).acquire)
      end

      @data
    end

    def distribute
      Sensor::OutputDistribution::FlowDock.new(self).distribute
    end
  end
end
