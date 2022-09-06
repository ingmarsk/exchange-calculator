# frozen_string_literal: true

module CurrencyServices
  class ConvertCurrencyService
    attr_reader :amount, :rates, :to

    def initialize(args)
      @amount = args[:amount]
      @rates = args[:rates]
      @to = args[:to]
    end

    def call
      if amount && rates[to]
        result = amount * rates[to]
        OpenStruct.new({success?: true, payload: result})
      else
        OpenStruct.new({success?: false, error: "\nError convering currency\n"})
      end
    end
  end
end
