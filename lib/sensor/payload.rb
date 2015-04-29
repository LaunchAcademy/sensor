require 'sensor'

Sensor.require("analytics_retrieval")
Sensor.require("twitter_retrieval")
Sensor.require("facebook_retrieval")
Sensor.require("flow_dock")
Sensor.require("slack")

module Sensor
  class Payload
    attr_reader :time_range, :data

    def initialize(time_range)
      @time_range = time_range
      @data = {}
    end

    def acquire
      actuator_classes.each do |actuator|
        @data.merge!(actuator.new(@time_range).acquire)
      end

      @data
    end

    def distribute
      if ENV['SLACK_WEBHOOK_URL']
        Sensor::OutputDistribution::Slack.new(self).distribute
      else
        Sensor::OutputDistribution::FlowDock.new(self).distribute
      end
    end

    def start_date
      @time_range.start_date
    end

    def end_date
      @time_range.end_date
    end

    protected
    def actuator_classes
      Sensor.configuration.actuators
    end
  end
end
