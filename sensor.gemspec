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

  spec.add_dependency 'chronic'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "timecop"
end
