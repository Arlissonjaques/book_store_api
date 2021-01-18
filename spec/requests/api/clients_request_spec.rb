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
end
