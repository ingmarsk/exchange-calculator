# frozen_string_literal: true

class CLI
  class << self
    AVAILABLE_CURRENCIES = ISO4217::Currency.currencies

    def start
      display_available_currencies

      from_currency = user_input(msg: 'From currency: ')
      to_currency = user_input(msg: 'To currency: ')
      amount = user_input(msg: 'Amount: ')

      display_error_msg and return unless valid_inputs?(from: from_currency, to: to_currency, amount: amount)

      exchange_rates = Services::ExchangeRateApi.new(currency: from_currency).call
      converted_currency = Services::CurrencyConverter.new(amount: amount.to_f,
                                                           to: to_currency,
                                                           rates: exchange_rates).call

      display_success_msg(amount, from_currency, to_currency, converted_currency)
    end

    def display_available_currencies
      puts "Available currencies (ISO 4217):\n\n"

      AVAILABLE_CURRENCIES.each_slice(5) do |slice|
        slice.each do |currency|
          puts "#{currency.first} - #{currency.last.name}"
        end
      end

      puts "\n"
    end

    def user_input(msg:)
      print msg
      gets.chomp
    end

    def valid_inputs?(from:, to:, amount:)
      return false unless AVAILABLE_CURRENCIES.map(&:first).include? from
      return false unless AVAILABLE_CURRENCIES.map(&:first).include? to

      begin
        Float(amount)
      rescue StandardError
        return false
      end

      true
    end

    def display_success_msg(amount, from_currency, to_currency, converted_currency)
      puts "\n#{amount} #{from_currency} equals to #{converted_currency} #{to_currency}\n\n"
    end

    def display_error_msg
      puts "\nInvalid inputs, please make sure currency is included in the list and the amount is a number\n\n"
    end
  end
end
