require 'garb'

CA_CERT_FILE = File.join(File.dirname(__FILE__),
  '../../../certs/cacert.pem')

module Sensor
  module Actuator
    class AnalyticsRetrieval
      extend Garb::Model

      metrics :visitors,
        :visit_bounce_rate,
        :avg_time_on_site,
        :pageviews

      def initialize(time_range)
        @time_range = time_range
      end

      def acquire
        results = self.class.results(profile,
          start_date: @time_range.start_date,
          end_date: @time_range.end_date)
        if results
          map = results.to_a[0].marshal_dump.inject({}) do |map, key_values|
            map[key_values[0]] = key_values[1].to_f
            map
          end
          {
            analytics: map
          }
        else
          {}
        end
      end

      protected
      def client
        if !@client
          session = Garb::Session.login(analytics_user, analytics_password)
        end

      end

      def analytics_user
        ENV['GOOGLE_ANALYTICS_USER']
      end

      def analytics_password
        ENV['GOOGLE_ANALYTICS_PASSWORD']
      end

      def analytics_profile_id
        ENV['GOOGLE_ANALYTICS_WEB_PROPERTY_ID']
      end

      def profile
        if !@profile
          client
          @profile = Garb::Management::Profile.all.detect do |p|
            p.web_property_id == analytics_profile_id
          end
        end
        @profile
      end
    end
  end
end
