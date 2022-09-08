# frozen_string_literal: true

# installed gems
require 'webmock/rspec'
require 'currencies'
require 'httparty'
require 'pry-byebug'

# binding.pry

# local clases
require 'services/application_service'
require 'services/exchange_rate_api_services/currency_rates_service'
require 'cli'

WebMock.disable_net_connect!(allow_localhost: true)
