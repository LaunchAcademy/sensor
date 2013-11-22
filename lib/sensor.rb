require "sensor/version"
require "sensor/date_range"

module Sensor
  def self.require(path)
    super("sensor/actuator/#{path}")
  end
end
