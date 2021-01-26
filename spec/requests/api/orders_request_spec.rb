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
      expect(json_response[0].keys).to match_array(%w[id client_id book_id form_of_payment_id created_at updated_at])
    end
  end

end