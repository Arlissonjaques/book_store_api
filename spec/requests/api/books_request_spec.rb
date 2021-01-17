require 'rails_helper'

RSpec.describe "Api::Books", type: :request do
  describe 'GET  api/books' do
    before do
      create(:book)
      create(:book)
      get '/api/books'
    end

    it 'return all books' do
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end

    it 'check JSON attributes' do
      json_response = JSON.parse(response.body)
      expect(json_response[0].keys).to match_array(%w[id name price author_id created_at updated_at])
    end
  end

  describe 'POST /api/books' do
    context 'with valid arguments' do
      it 'book created' do
        author = create(:author)
        post '/api/books/', params: { name: author.name, price: Faker::Number.within(range: 10..70), author_id: author.id }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid arguments' do
      it 'book created' do
        author = create(:author)
        post '/api/books/', params: { name: author.name }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

end