require 'sensor/payload'

module Sensor
  class RakeTask < Rake::TaskLib
    def initialize(name)
      desc "run sensors for yesterday"
      namespace name do
        task :yesterday do
          yesterday = Date.today - 1
          time_range = Sensor::TimeRange.new(yesterday, yesterday)
          payload = Sensor::Payload.new(time_range)
          payload.acquire
          payload.distribute
        end


        task :last_week do
          today = Date.today
          week_start = today - today.wday - 6
          week_end = week_start + 6

          time_range = Sensor::TimeRange.new(week_start, week_end)
          payload = Sensor::Payload.new(time_range)
          payload.acquire
          payload.distribute
        end
      end

    end


    def run_task
    end
  end
end
