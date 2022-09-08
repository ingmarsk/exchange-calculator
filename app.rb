# frozen_string_literal: true

# load installed gems
require 'currencies'
require 'httparty'
require 'pry-byebug'

# load local ruby files
Dir.glob(File.join('lib', '**', '*.rb')).each do |file|
  require_relative file
end

# Start program
CLI.start
