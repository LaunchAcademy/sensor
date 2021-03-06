require 'sensor/configuration'

module Sensor
  class << self
    attr_accessor :configuration

    def configure(&block)
      @configuration = Sensor::Configuration.new(&block)
    end

    def configuration
      @configuration ||= Sensor::Configuration.new
    end

    def require(path)
      begin
        super("sensor/actuator/#{path}")
      rescue LoadError => e
        if e.message =~ /#{Regexp.escape(path)}/
          super("sensor/output_distribution/#{path}")
        else
          raise e
        end
      end
    end
  end
end

require "sensor/version"
require "sensor/time_range"

require "sensor/payload"
