# Sensor

A utility that reports metrics from social media and analytics providers.

## Installation

Add this line to your application's Gemfile:

    gem 'sensor'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sensor

## Usage

**This is in draft mode and is not yet stable for use**

Desired configuration:

```ruby
Sensor.add_source :twitter, {
    account: 'launchacademy_',
    consumer_key: ENV['TWITTER_CONSUMER_KEY'],
    consumer_secret: ENV['TWITTER_CONSUMER_SECRET'],
    access_token: ENV['TWITTER_ACCESS_TOKEN'],
    access_token_secret: ENV['TWITTER_ACCESS_TOKEN_SECRET']
  }, 
  metrics: [:followers, :tweets, :mentions]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
