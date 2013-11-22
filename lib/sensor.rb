require "sensor/version"
require "sensor/time_range"

module Sensor
  def self.require(path)
    super("sensor/actuator/#{path}")
  end
end
