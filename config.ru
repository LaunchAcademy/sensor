require 'sinatra'

require 'omniauth-facebook'
require 'dotenv'
require 'omniauth/google_oauth2'
Dotenv.load

require 'koala'

class App < Sinatra::Base
  set :protection, :except => :frame_options

  get '/auth/:provider/callback' do
    content_type 'application/json'
    provider = request.env['omniauth.auth']['provider']
    if provider == 'facebook'
      session[:fb_access_token] = request.env['omniauth.auth']['credentials']['token']
      graph = Koala::Facebook::API.new(session[:fb_access_token])
      graph.get_page_access_token(ENV['FACEBOOK_PAGE'])
    else
      request.env['omniauth.auth']['credentials']['refresh_token']
    end
  end
end

use Rack::Session::Cookie, :key => 'rack.session',
                           :domain => 'localhost',
                           :path => '/',
                           :expire_after => 2592000, # In seconds
                           :secret => ENV['COOKIE_SECRET']

use OmniAuth::Builder do
  provider :facebook,
    ENV['FACEBOOK_API_KEY'],
    ENV['FACEBOOK_SECRET_KEY'],
    scope: "manage_pages,read_insights",
    provider_ignores_state: true
  provider :google_oauth2,
    ENV["GOOGLE_CLIENT_ID"],
    ENV["GOOGLE_CLIENT_SECRET"],
    scope: 'https://www.googleapis.com/auth/analytics.readonly,email',
    provider_ignores_state: true,
    prompt: 'consent'
end

run App.new
