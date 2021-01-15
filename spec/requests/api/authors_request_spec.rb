require 'rails_helper'

RSpec.describe 'Api::Authors', type: :request do
  describe 'GET api/authors' do
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
  # POST
  describe 'POST /api/authors' do
    it 'author created' do
      post '/api/authors/', params: { name: :author }
      expect(response).to have_http_status(:created)
    end
  end

  describe 'PUT /api/authors/x' do
    context 'when author exist' do
      it 'record update' do
        author = create(:author)
        author_attributes = attributes_for(:author)
        put "/api/authors/#{author.id}", params: author_attributes
        expect(author.reload).to have_attributes(author_attributes)
      end
    end

    context 'with author does not exist' do
      it 'returns status code 404' do
        put '/api/authors/0', params: attributes_for(:author)
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE api/authors/x' do
    context 'when author exists' do
      it 'excluding author' do
        author = create(:author)
        delete "/api/authors/#{author.id}"
        expect(response).to have_http_status(204)
      end

      it 'destroy record' do
        author = create(:author)
        delete "/api/authors/#{author.id}"
        expect { author.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end

  end
end