$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rubygems'
require 'bundler/setup'

Dir["#{File.expand_path('../support', __FILE__)}/*.rb"].each do |file|
  require file
end

require 'site_builder_client'

RSpec.configure do |config|
  # config.include Spec::Helpers

  # config.filter_run focused: true
  # config.run_all_when_everything_filtered = true

  # config.before { reset! }
  # config.after  { reset! }

  config.order = :random
end
