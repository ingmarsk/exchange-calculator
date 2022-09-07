# frozen_string_literal: true

module CliServices
  class UserInputService < ApplicationService
    attr_reader :from_currency, :to_currency, :amount

    def initialize
      @from_currency = user_input(msg: 'From currency: ')
      @to_currency = user_input(msg: 'To currency: ')
      @amount = user_input(msg: 'Amount: ')
    end

    def call
      if valid_inputs?
        self.class.success_response.new(success?: true,
                                        payload: {
                                          from_currency: from_currency, to_currency: to_currency, amount: amount
                                        })
      else
        self.class.error_response.new(success?: false, error: error_msg)
      end
    end

    private

    def valid_inputs?
      return false unless CLI::AVAILABLE_CURRENCIES.map(&:first).include? from_currency
      return false unless CLI::AVAILABLE_CURRENCIES.map(&:first).include? to_currency

      begin
        Float(amount)
      rescue StandardError
        return false
      end

      true
    end

    def user_input(msg:)
      print msg
      gets.chomp
    end

    def error_msg
      "\nInvalid inputs, please make sure currency is included in the list and the amount is a number\n"
    end
  end
end
