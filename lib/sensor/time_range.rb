require 'chronic'

module Sensor
  class TimeRange
    attr_reader :start, :end
    def initialize(start_date, end_date)
      @start = timify(start_date)
      @end = timify(end_date, true)
    end

    def start_date
      datify(@start)
    end

    def end_date
      datify(@end)
    end

    protected
    def datify(time)
      Date.new(time.year, time.month, time.day)
    end

    def timify(date, as_end = false)
      if date.kind_of?(String)
        Chronic.parse(date)
      elsif date.kind_of?(Date)
        as_end ? (date + 1).to_time - 1 : date.to_time
      elsif date.kind_of?(Time)
        date
      else
        raise "Unknown date parameter: #{date}"
      end
    end
  end
end
