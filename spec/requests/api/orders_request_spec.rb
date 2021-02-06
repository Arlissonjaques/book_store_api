require 'rails_helper'

RSpec.describe "Api::Orders", type: :request do

  describe 'GET api/orders' do
    before do
      form = FormOfPayment.create(type_payment: "Boleto")
      Order.create(client_id: create(:client).id, book_id: create(:book).id, form_of_payment_id: form.id)
      Order.create(client_id: create(:client).id, book_id: create(:book).id, form_of_payment_id: form.id)

      get '/api/orders'
    end

    it 'return all orders' do
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end

    it 'check JSON attributes' do
      json_response = JSON.parse(response.body)
      expect(json_response[0].keys).to include('id', 'client_id', 'book_id', 'form_of_payment_id', 'book_references')
    end
  end

  describe 'POST /api/orders' do
    context 'with valid arguments' do
      it 'order created' do
        form = FormOfPayment.create(type_payment: 'Boleto')
        post '/api/orders/', params: { client_id: create(:client).id, book_id: create(:book).id, form_of_payment_id: form.id }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid arguments' do
      it 'order created' do
        form = FormOfPayment.create(type_payment: 'Boleto')
        post '/api/orders/', params: { client_id: create(:client).id }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /api/orders/x' do

    it 'record update' do
      form = FormOfPayment.create(type_payment: 'Boleto')
      order = Order.create(client_id: create(:client).id, book_id: create(:book).id, form_of_payment_id: form.id)
      order_attributes = { 'client_id': 1, 'book_id': 1, 'form_of_payment_id': 1 }
      put "/api/clients/#{order.id}", params: order_attributes
      expect(order.reload).to have_attributes(order_attributes.slice(:client_id, :book_id, :form_of_payment_id))
    end

    context 'with invalid arguments' do
      it 'order created' do
        form = FormOfPayment.create(type_payment: 'Boleto')
        order = Order.create(client_id: create(:client).id, book_id: create(:book).id, form_of_payment_id: form.id)
        put "/api/orders/#{order.id}", params: { client_id: '' }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE api/orders/x' do
    context 'when order exists' do
      it 'excluding order' do
        form = FormOfPayment.create(type_payment: 'Boleto')
        order = Order.create(client_id: create(:client).id, book_id: create(:book).id, form_of_payment_id: form.id)
        delete "/api/orders/#{order.id}"
        expect(response).to have_http_status(204)
      end

      it 'destroy record' do
        form = FormOfPayment.create(type_payment: 'Boleto')
        order = Order.create(client_id: create(:client).id, book_id: create(:book).id, form_of_payment_id: form.id)
        delete "/api/orders/#{order.id}"
        expect { order.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

end
