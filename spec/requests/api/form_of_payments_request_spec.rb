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

  describe 'PUT /api/form_of_payments/x' do
    context 'when form_of_payment exist' do
      it 'record update' do
        form_of_payment = create(:form_of_payment)
        form_of_payment_attributes = attributes_for(:form_of_payment)
        put "/api/form_of_payments/#{form_of_payment.id}", params: form_of_payment_attributes
        expect(form_of_payment.reload).to have_attributes(form_of_payment_attributes.slice(:firstname, :lastname, :email))
      end
    end

    context 'with invalid arguments' do
      it 'form_of_payment created' do
        post '/api/form_of_payments/', params: { type_payment: " " }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with form_of_payment does not exist' do
      it 'returns status code 404' do
        put '/api/form_of_payments/0', params: attributes_for(:form_of_payment)
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE api/form_of_payments/x' do
    context 'when form_of_payment exists' do
      it 'excluding form_of_payment' do
        form_of_payment = create(:form_of_payment)
        delete "/api/form_of_payments/#{form_of_payment.id}"
        expect(response).to have_http_status(204)
      end

      it 'destroy record' do
        form_of_payment = create(:form_of_payment)
        delete "/api/form_of_payments/#{form_of_payment.id}"
        expect { form_of_payment.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end

  end

end
