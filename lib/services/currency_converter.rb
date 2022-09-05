# frozen_string_literal: true

module Services
  class CurrencyConverter
    attr_reader :to, :amount, :rates

    def initialize(amount:, rates:, to:)
      @amount = amount
      @rates = rates
      @to = to
    end

    def call
      return if amount.nil? || rates[to].nil?

      amount * rates[to]
    end
  end
end
