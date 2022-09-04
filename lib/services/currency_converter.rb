# frozen_string_literal: true

module Services
  class CurrencyConverter
    attr_reader :from, :to, :amount

    def initialize(amount:, from:, to:)
      @amount = amount
      @from = from
      @to = to
    end

    def call
      rates = Services::ExchangeRateApi.new(currency: from).get_rates
      amount * rates[to]
    end
  end
end
