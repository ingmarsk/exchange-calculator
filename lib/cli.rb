# frozen_string_literal: true

class CLI
  AVAILABLE_CURRENCIES = ISO4217::Currency.currencies

  class << self
    def start
      display_available_currencies

      user_inputs = CliServices::UserInputService.new.call

      puts user_inputs.error and return unless user_inputs.success?

      from_currency = user_inputs.payload[:from_currency]
      to_currency = user_inputs.payload[:to_currency]
      amount = user_inputs.payload[:amount]

      rates = ExchangeRateApiServices::CurrencyRatesService.new(currency: from_currency).call

      if rates.success?
        conversion = CurrencyServices::ConvertCurrencyService.new(rates: rates.payload, amount: amount.to_f, to: to_currency).call

        if conversion.success?
          handle_success(amount, from_currency, to_currency, conversion.payload)
        else
          handle_error(conversion&.error)
        end
      else
        handle_error(rates&.error)
      end
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

    def handle_success(amount, from_currency, to_currency, converted_currency)
      puts "\n#{amount} #{from_currency} equals to #{converted_currency} #{to_currency}\n\n"
    end

    def handle_error(error)
      puts "\n#{error}\n"
    end
  end
end
