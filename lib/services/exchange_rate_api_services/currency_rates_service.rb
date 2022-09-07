# frozen_string_literal: true

module ExchangeRateApiServices
  class CurrencyRatesService < ApplicationService
    attr_reader :currency

    def initialize(args)
      @currency = args[:currency]
    end

    def call
      response = HTTParty.get("https://open.er-api.com/v6/latest/#{currency}")
    rescue HTTParty::Error => e
      self.class.error_response.new({ success?: false, error: e })
    else
      self.class.success_response.new({ success?: true, payload: response['rates'] })
    end
  end
end
