# frozen_string_literal: true

module Services
  class ExchangeRateApi
    include HTTParty
    base_uri 'open.er-api.com/v6/latest'

    attr_reader :currency

    def initialize(currency:)
      @currency = currency
    end

    def call
      response = self.class.get("/#{currency}")
      rates = response['rates']

      rates.nil? ? {} : rates
    end
  end
end
