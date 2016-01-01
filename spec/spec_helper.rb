$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'honey_sheet'

require 'active_support/core_ext/hash'
require 'pry'

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }

RSpec.configure do |config|
  config.include Fixture
end
