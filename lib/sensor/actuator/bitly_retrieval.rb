module Sensor
  module Actuator
    class BitlyRetrieval
      def initialize(time_range)
        @time_range = time_range
      end

      def acquire
        {}.tap do |map|
        end
      end

      def link_history
        {
          user: user,
          created_after: created_after,
          created_before: created_before
        }
      end

      protected
      def created_after
        time_range.start.to_i
      end

      def created_before
        time_range.end.to_i
      end

      def client
      end

      def access_token
        ENV['BITLY_ACCESS_TOKEN']
      end
    end
  end
end
