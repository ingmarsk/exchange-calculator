# frozen_string_literal: true

module ExchangeRateApiServices
  class CurrencyRatesService < ApplicationService
    attr_reader :currency

    def initialize(args)
      @currency = args[:currency]
    end

    def call
      response = HTTParty.get("https://open.er-api.com/v6/latest/#{currency}")

      if response.success?
        rates = JSON.parse(response.body)['rates']
        self.class.success_response.new({ success?: true, payload: rates })
      else
        self.class.error_response.new({ success?: false, error: "Rates not found for #{currency}" })
      end
    rescue HTTParty::Error => error
      self.class.error_response.new({ success?: false, error: error })
    end
  end
end
