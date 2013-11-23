require 'sensor'

require 'rspec'

require 'timecop'

require 'vcr'
require 'webmock'

require 'dotenv'
Dotenv.load

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
  c.configure_rspec_metadata!
end

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
end
