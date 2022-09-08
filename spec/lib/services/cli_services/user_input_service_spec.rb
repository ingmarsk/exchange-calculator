# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CliServices::UserInputService do
  subject(:service) { described_class.new }

  describe '.call' do
    before do
      allow(service).to receive(:user_input).with(msg: 'From currency: ').and_return(from_currency_input)
      allow(service).to receive(:user_input).with(msg: 'To currency: ').and_return(to_currency_input)
      allow(service).to receive(:user_input).with(msg: 'Amount: ').and_return(amount_input)
    end

    context 'with valid user inputs' do
      let(:from_currency_input) { 'USD' }
      let(:to_currency_input) { 'EUR' }
      let(:amount_input) { 1 }

      it 'succeeds' do
        expect(service.call).to be_success
      end

      it 'returns the user inputs on the payload' do
        payload = {
          from_currency: from_currency_input,
          to_currency: to_currency_input,
          amount: amount_input
        }

        expect(service.call.payload).to eq(payload)
      end
    end

    context 'with invalid user inputs' do
      let(:from_currency_input) { '' }
      let(:to_currency_input) {  }
      let(:amount_input) { 1 }

      it 'fails' do
        expect(service.call).not_to be_success
      end

      it 'returns an error message' do
        expect(service.call).to respond_to(:error)
      end
    end
  end
end