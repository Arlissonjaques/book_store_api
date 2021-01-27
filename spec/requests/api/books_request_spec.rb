require 'rails_helper'

RSpec.describe "Api::Books", type: :request do
  describe 'GET  api/books' do
    before do
      create_list(:book, 2)
      get '/api/books'
    end

    it 'return all books' do
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end

    it 'check JSON attributes' do
      json_response = JSON.parse(response.body)
      expect(json_response[0].keys).to include('id', 'name', 'author_id')
    end
  end

  describe 'POST /api/books' do
    context 'with valid arguments' do
      it 'book created' do
        book = create(:book)
        post '/api/books/', params: { name: book.name, price: book.price, author_id: book.author_id }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid arguments' do
      it 'book created' do
        post '/api/books/', params: { name: '' }
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
        put "/api/books/#{create(:book).id}", params: { name: '' }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE api/books/x' do
    context 'when book exists' do

      it 'excluding book' do
        delete "/api/books/#{create(:book).id}"
        expect(response).to have_http_status(204)
      end

      it 'destroy record' do
        book = create(:book)
        delete "/api/books/#{book.id}"
        expect { book.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end

  end
end