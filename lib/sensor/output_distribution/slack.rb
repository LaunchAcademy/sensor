require 'slack-notifier'

module Sensor
  module OutputDistribution
    class Slack
      def initialize(payload)
        @payload = payload
      end

      def distribute
        notifier.ping(content)
      end

      protected
      def content
        @payload.data.inject("") do |str, key_value|
          str += "*#{key_value[0]}*\r\n"

          key_value[1].each do |attribute, value|
            str += "  - *#{attribute}*: #{value}\r\n"
          end
          str
        end
      end

      def notifier
        @notifier ||= ::Slack::Notifier.new(
          ENV['SLACK_WEBHOOK_URL'],
          {
            channel: ENV['SLACK_CHANNEL']
          }
        )
      end
    end
  end
end
