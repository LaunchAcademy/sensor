require 'koala'
module Sensor
  module Actuator
    class FacebookRetrieval
      def initialize(time_range)
        @time_range = time_range
      end

      def acquire
        results = graph.get_object("TheLaunchAcademy")
        likes = results["likes"]
        talking = results["talking_about_count"]
        posts = graph.get_object("TheLaunchAcademy/posts",
          since: format_date(@time_range.start_date),
          until: format_date(@time_range.end_date),
          limit: 200
        )

        post_likes = posts.inject(0) do |post_likes, post|
          if post["likes"] && post["likes"]["data"]
            post_likes += post["likes"]["data"].size
          else
            post_likes
          end
        end

        {
          facebook: {
            likes: likes,
            talking: talking,
            posts: posts.size,
            post_likes: post_likes
          }
        }
      end

      protected
      def format_date(date)
        date.strftime("%Y-%m-%d")
      end

      def graph
        @graph ||= Koala::Facebook::API.new(access_token)
      end

      def oauth_url
        "https://www.facebook.com/dialog/oauth?" +
          "client_id=#{api_key}&client_secret=#{secret_key}" +
          "scope=manage_pages,read_insights&redirect_uri=#{redirect_uri}&" +
          "response_type=token"
      end

      def token_exchange_url
        "https://www.facebook.com/oauth/access_token?" +
          "grant_type=fb_exchange_token&" +
          "client_id=#{api_key}&" +
          "client_secret=#{secret_key}&" +
          "fb_exchange_token=#{short_lived_token}"
      end

      def redirect_uri
        ENV['FACEBOOK_REDIRECT_URI']
      end

      def short_lived_token
        ENV['FACEBOOK_SHORT_LIVED_TOKEN']
      end

      def access_token
        ENV['FACEBOOK_TOKEN']
      end

      def api_key
        ENV['FACEBOOK_API_KEY']
      end

      def secret_key
        ENV['FACEBOOK_SECRET_KEY']
      end
    end
  end
end
