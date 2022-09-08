# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CurrencyServices::ConvertCurrencyService do
  subject(:service) { described_class.new(args) }

  let(:currency) { 'USD' }
  let(:amount) { 1 }
  let(:rates) { { 'USD' => 1.004402 } }

  describe '.call' do
    context 'with valid args' do
      let(:args) { { currency: currency, amount: amount, rates: rates } }

      it 'succeeds' do
        expect(service.call).to be_success
      end

      it 'returns the amount converted to the chosen currency' do
        expect(service.call.payload).to eq(amount * rates[currency])
      end
    end

    context 'with invalid args' do
      let(:args) { { currency: nil, amount: nil, rates: [] } }

      it 'fails' do
        expect(service.call).not_to be_success
      end

      it 'returns an error message' do
        expect(service.call).to respond_to(:error)
      end
    end
  end
end
