# frozen_string_literal: true

module CurrencyServices
  class ConvertCurrencyService < ApplicationService
    attr_reader :currency, :amount, :rates

    def initialize(args)
      @currency = args[:currency]
      @amount = args[:amount]
      @rates = args[:rates]
    end

    def call
      if amount && rates[currency]
        result = amount * rates[currency]

        self.class.success_response.new({ success?: true, payload: result })
      else
        self.class.error_response.new({ success?: false, error: "\nError convering currency\n" })
      end
    end
  end
end
