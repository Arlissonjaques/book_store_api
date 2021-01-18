class Api::BooksController < ApplicationController

  before_action :set_book, only: [:update, :destroy]

  def index
    render json: Book.all
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      render json: @book, status: :created
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      render json: @book, status: :ok
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    # render json: {'message': 'data deleted successfully'}
  end

  private

  def set_book
    @book = Book.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: :not_found
  end

  def book_params
    params.permit(:name, :price, :author_id)
  end
end
