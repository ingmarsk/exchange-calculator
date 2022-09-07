# frozen_string_literal: true

# load installed gems
require 'currencies'
require 'httparty'
require 'pry-byebug'

# load local files
require_relative 'lib/cli'
require_relative 'lib/services/application_service'
require_relative 'lib/services/exchange_rate_api_services/currency_rates_service'
require_relative 'lib/services/currency_services/convert_currency_service'
require_relative 'lib/services/cli_services/user_input_service'

# Start program
CLI.start
