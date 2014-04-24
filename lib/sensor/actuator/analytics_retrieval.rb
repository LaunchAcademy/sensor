require 'garb'
require 'oauth2'

module Sensor
  module Actuator
    class AnalyticsRetrieval
      CA_CERT_FILE = File.join(File.dirname(__FILE__),
        '../../../certs/cacert.pem')

      extend Garb::Model

      metrics :visitors,
        :visit_bounce_rate,
        :avg_time_on_site,
        :pageviews

      def initialize(time_range)
        @time_range = time_range
        client = OAuth2::Client.new(ENV['GOOGLE_CLIENT_ID'],
          ENV['GOOGLE_CLIENT_SECRET'],
          {
            site: 'https://accounts.google.com',
            authorize_url: "/o/oauth2/auth",
            token_url: "/o/oauth2/token"
          })
        token = OAuth2::AccessToken.from_hash(client, refresh_token: ENV['GOOGLE_REFRESH_TOKEN']).refresh!
        Garb::Session.access_token = token
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

      class << self
        def enable_garb_ssl!
          Garb.ca_cert_file = CA_CERT_FILE
        end
      end

      protected
      def analytics_profile_id
        ENV['GOOGLE_ANALYTICS_WEB_PROPERTY_ID']
      end

      def profile
        if !@profile
          @profile = Garb::Management::Profile.all.detect do |p|
            p.web_property_id == analytics_profile_id
          end
        end
        @profile
      end
    end
  end
end

Sensor::Actuator::AnalyticsRetrieval.enable_garb_ssl!
