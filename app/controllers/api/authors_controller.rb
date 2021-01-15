class Api::AuthorsController < ApplicationController
  def index
    render json: Author.all
  end

  def create
    author = Author.new(author_params)

    if author.save
      render json: author, status: :created
    else
      render json: author.errors, status: :unprocessable_entity
    end
  end

  private

  def author_params
    params.permit(:name)
  end

end
