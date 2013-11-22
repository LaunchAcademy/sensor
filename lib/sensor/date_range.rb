require 'chronic'

module Sensor
  class DateRange
    attr_reader :start, :end
    def initialize(start_date, end_date)
      @start = datify(start_date)
      @end = datify(end_date, true)
    end

    protected
    def datify(date, as_end = false)
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
