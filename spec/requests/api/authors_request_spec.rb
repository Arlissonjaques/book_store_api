require 'rails_helper'

RSpec.describe "Api::Authors", type: :request do
  describe "GET api/authors" do
    before do
      create(:author)
      create(:author)
      get '/api/authors'
    end

    it 'return all authors' do
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end

    it 'check JSON attributes' do
      json_response = JSON.parse(response.body)
      expect(json_response[0].keys).to match_array(%w[id name created_at updated_at])
    end
  end

end
