require 'flowdock'

module Sensor
  module OutputDistribution
    class FlowDock
      def initialize(payload)
        @payload = payload
        @time_range = payload.time_range
      end

      def distribute
        flow.push_to_team_inbox({
          subject: "Sensor Output: " +
            "#{format_date(@payload.start_date)} - " +
            "#{format_date(@payload.end_date)}",
          content: content
        })
      end

      protected
      def format_date(date)
        date.strftime("%m/%d/%Y")
      end

      def content
        @payload.data.inject("") do |str, key_value|
          str += "<h3>#{key_value[0]}</h3>"

          str += "<ul>"
          key_value[1].each do |attribute, value|
            str += "<li><strong>#{attribute}</strong>: #{value}</li>"
          end
          str += "</ul>"
        end
      end

      def flow
        @flow ||= ::Flowdock::Flow.new(
          api_token: token,
          source: 'Sensor',
          from: {
            name: 'Sensor',
            address: 'hello@sensor.com'
          }
        )
      end

      def token
        ENV['FLOWDOCK_TOKEN']
      end
    end
  end
end

