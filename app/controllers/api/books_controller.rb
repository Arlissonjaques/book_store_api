class Api::BooksController < ApplicationController

  def index
    render json: Book.all
  end

end
