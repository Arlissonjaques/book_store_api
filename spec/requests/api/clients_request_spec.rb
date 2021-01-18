require 'rails_helper'

RSpec.describe "Api::Clients", type: :request do
  describe 'GET  api/clients' do
    before do
      create(:client)
      create(:client)
      get '/api/clients'
    end

    it 'return all clients' do
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end

    it 'check JSON attributes' do
      json_response = JSON.parse(response.body)
      expect(json_response[0].keys).to match_array(%w[id firstname lastname email created_at updated_at])
    end
  end

  describe 'POST /api/clients' do
    context 'with valid arguments' do
      it 'client created' do
        client = create(:client)
        post '/api/clients/', params: { firstname: client.firstname, lastname: client.lastname, email: "teste@email.com" }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid arguments' do
      it 'client created' do
        author = create(:author)
        post '/api/clients/', params: { name: author.name }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
