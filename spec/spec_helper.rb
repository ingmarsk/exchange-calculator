# frozen_string_literal: true

# installed gems
require 'webmock/rspec'
require 'currencies'
require 'httparty'
require 'pry-byebug'

WebMock.disable_net_connect!(allow_localhost: true)

# load local ruby files
Dir.glob(File.join('lib', '**', '*.rb')).each do |path|
  require path.gsub('lib/', '')
end
