# frozen_string_literal: true

# load installed gems
require 'currencies'
require 'httparty'

# load local files
require_relative 'lib/services/exchange_rate_api'
require_relative 'lib/services/currency_converter'
require_relative 'lib/cli'

# Start program
CLI.start
