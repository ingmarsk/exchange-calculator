# frozen_string_literal: true

module CurrencyServices
  class ConvertCurrencyService < ApplicationService
    attr_reader :amount, :rates, :to

    def initialize(args)
      @amount = args[:amount]
      @rates = args[:rates]
      @to = args[:to]
    end

    def call
      if amount && rates[to]
        result = amount * rates[to]

        self.class.success_response.new({ success?: true, payload: result })
      else
        self.class.error_response.new({ success?: false, error: "\nError convering currency\n" })
      end
    end
  end
end
