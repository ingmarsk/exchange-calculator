# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe CLI do
  let(:cli) { described_class }

  let(:rate_service) { instance_double(Services::ExchangeRateApi) }
  let(:converter_service) { instance_double(Services::CurrencyConverter) }

  describe '.start' do
    before do
      allow(rate_service).to receive(:call)
      allow(converter_service).to receive(:call)

      allow(cli).to receive(:display_available_currencies)
      allow(cli).to receive(:user_input).with(msg: 'From currency: ').and_return(from_currency_input)
      allow(cli).to receive(:user_input).with(msg: 'To currency: ').and_return(to_currency_input)
      allow(cli).to receive(:user_input).with(msg: 'Amount: ').and_return(amount)
    end

    context 'with invalid from_currency input value' do
      let(:from_currency_input) { 'ABC123' }
      let(:to_currency_input) { 'USD' }
      let(:amount) { 1 }

      it 'returns an error message' do
        expect { cli.start }.to output(cli.display_error_msg).to_stdout
      end
    end

    context 'with invalid to_currency input value' do
      let(:from_currency_input) { 'EUR' }
      let(:to_currency_input) { '123' }
      let(:amount) { 1.0 }

      it 'returns an error message' do
        expect { cli.start }.to output(cli.display_error_msg).to_stdout
      end
    end

    context 'with invalid amount input value' do
      let(:from_currency_input) { 'EUR' }
      let(:to_currency_input) { 'USD' }
      let(:amount) { 'abc' }

      it 'returns an error message' do
        expect { cli.start }.to output(cli.display_error_msg).to_stdout
      end
    end
  end
end
