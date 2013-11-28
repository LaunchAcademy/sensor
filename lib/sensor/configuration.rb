module Sensor
  class Configuration
    attr_accessor :actuators

    def initialize(&block)
      yield(self) if block_given?

      assign_defaults!
    end

    def append_actuator(actuator_class)
      @actuators ||= []
      unless @actuators.include?(actuator_class)
        @actuators << actuator_class
      end
    end

    protected
    def assign_defaults!
      Sensor.require("analytics_retrieval")
      Sensor.require("facebook_retrieval")
      Sensor.require("twitter_retrieval")
      self.actuators = [
        Sensor::Actuator::AnalyticsRetrieval,
        Sensor::Actuator::FacebookRetrieval,
        Sensor::Actuator::TwitterRetrieval
      ]
    end
  end
end
