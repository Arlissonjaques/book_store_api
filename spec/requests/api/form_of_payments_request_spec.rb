require 'rails_helper'

RSpec.describe "Api::FormOfPayments", type: :request do
  describe 'GET  api/form_of_payments' do
    before do
      form1 = FormOfPayment.create(type_payment: "Cartao de Credito")
      form2 = FormOfPayment.create(type_payment: "Boleto Bancario")
      get '/api/form_of_payments'
    end

    it 'return all forms of payments' do
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end

    it 'check JSON attributes' do
      json_response = JSON.parse(response.body)
      expect(json_response[0].keys).to match_array(%w[id type_payment created_at updated_at])
    end
  end

  describe 'POST /api/form_of_payments' do
    context 'with valid arguments' do
      it 'form_of_payment created' do
        post '/api/form_of_payments/', params: { type_payment: 'Boleto'}
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid arguments' do
      it 'should not create' do
        post '/api/form_of_payments/', params: { name: " " }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
