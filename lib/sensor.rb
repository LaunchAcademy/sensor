module Sensor
  def self.require(path)
    begin
      super("sensor/actuator/#{path}")
    rescue LoadError
      super("sensor/output_distribution/#{path}")
    end
  end
end

require "sensor/version"
require "sensor/time_range"

require "sensor/payload"
