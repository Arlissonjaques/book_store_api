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
        book = create(:book)
        post '/api/books/', params: { name: book.name, price: Faker::Number.within(range: 10..70), author_id: book.author_id }
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

  describe 'PUT /api/books/x' do
    context 'when book exist' do
      it 'record update' do
        book = create(:book)
        book_attributes = attributes_for(:book)
        put "/api/books/#{book.id}", params: book_attributes
        expect(book.reload).to have_attributes(book_attributes)
      end
    end

    context 'with invalid arguments' do
      it 'book created' do
        book = create(:book)
        post '/api/books/', params: { name: book.name }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with book does not exist' do
      it 'returns status code 404' do
        put '/api/authors/0', params: attributes_for(:author)
        expect(response).to have_http_status(404)
      end
    end
  end

end