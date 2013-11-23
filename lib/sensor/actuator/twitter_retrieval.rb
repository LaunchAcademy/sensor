require 'twitter'

module Sensor
  module Actuator
    class TwitterRetrieval
      def initialize(time_range)
        @time_range = time_range
      end

      def acquire
        map = {}
        map.tap do |map|
          map[:twitter] = {}
          map[:twitter][:followers] = client.user.followers_count
          map[:twitter][:tweets] = tweet_count
          map[:twitter][:mentions] = mention_count
        end
      end

      protected
      def format_date(date)
        date.strftime("%Y-%m-%d")
      end

      def search_options
        {
          count: 100,
          since: format_date(@time_range.start_date),
          until: format_date(@time_range.end_date)
        }
      end

      def tweet_count
        search = client.search("from:launchacademy_",
          search_options
        )
        search.entries.count
      end

      def mention_count
        search = client.search("to:launchacademy_",
          search_options)
        search.entries.count
      end

      def client
        if !@client
          @client = Twitter::REST::Client.new do |config|
            config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
            config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
            config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
            config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
          end
        end
        @client
      end
    end
  end
end
