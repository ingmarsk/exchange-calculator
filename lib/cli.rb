# frozen_string_literal: true

class CLI
  AVAILABLE_CURRENCIES = ISO4217::Currency.currencies

  def self.start
    display_available_currencies

    from_currency = user_input(msg: 'From currency: ')
    to_currency = user_input(msg: 'To currency: ')
    amount = user_input(msg: 'Amount: ')

    display_error_msg and return unless valid_inputs?(from: from_currency, to: to_currency, amount: amount)

    converted_currency = Services::CurrencyConverter.new(amount: amount.to_f, from: from_currency, to: to_currency).call

    display_success_msg(amount, from_currency, to_currency, converted_currency)
  end

  private

  def self.display_available_currencies
    puts "Available currencies (ISO 4217):\n\n"

    AVAILABLE_CURRENCIES.each_slice(5) do |slice|
      slice.each do |currency|
        puts "#{currency.first} - #{currency.last.name}"
      end
    end

    puts "\n"
  end

  def self.user_input(msg:)
    print msg
    gets.chomp
  end

  def self.valid_inputs?(from:, to:, amount:)
    return false unless AVAILABLE_CURRENCIES.map(&:first).include? from
    return false unless AVAILABLE_CURRENCIES.map(&:first).include? to
    Float(amount) rescue return false

    true
  end

  def self.display_success_msg(amount, from_currency, to_currency, converted_currency)
    puts "\n#{amount} #{from_currency} equals to #{converted_currency} #{to_currency}\n\n"
  end

  def self.display_error_msg
    puts "\nInvalid inputs, please make sure currency is included in the list and the amount is a number\n\n"
  end
end
