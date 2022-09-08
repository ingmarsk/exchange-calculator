# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ExchangeRateApiServices::CurrencyRatesService do
  subject(:service) { described_class.new(args) }

  let(:response_body) { File.read('./spec/fixtures/usd_rates_response.json') }
  let(:base_uri) { "https://open.er-api.com/v6/latest/#{currency}" }
  let(:args) { { currency: currency } }
  let(:currency) { 'USD' }

  describe '.call' do
    context 'when the service succeeds' do
      before do
        stub_request(:get, base_uri).to_return(status: 200, body: response_body.to_json)
      end

      it 'the :success? method value is true' do
        expect(service.call).to be_success
      end

      it 'returns the exchange rates from the given currency' do
        expect(service.call.payload).to eq(response_body['rates'])
      end
    end
  end
end
