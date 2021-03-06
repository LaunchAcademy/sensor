# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sensor/version'

Gem::Specification.new do |spec|
  spec.name          = "sensor"
  spec.version       = Sensor::VERSION
  spec.authors       = ["Dan Pickett"]
  spec.email         = ["dan.pickett@launchware.com"]
  spec.description   = %q{Sensor provides a set of marketing metrics}
  spec.summary       = %q{Marketing Metrics Acquisition Tool}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "chronic"
  spec.add_dependency "garb", "~> 0.9.1"
  spec.add_dependency "twitter", "~> 5.0.0"
  spec.add_dependency "koala"
  spec.add_dependency "flowdock"
  spec.add_dependency "slack-notifier"
  spec.add_dependency "rake"
  spec.add_dependency "oauth2"

  spec.add_development_dependency "bundler", "~> 1.3"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "timecop"
  spec.add_development_dependency "dotenv"

  spec.add_development_dependency "sinatra"
  spec.add_development_dependency "shotgun"
  spec.add_development_dependency "omniauth-facebook"
  spec.add_development_dependency "omniauth-google-oauth2"
end
