class Api::AuthorsController < ApplicationController

  before_action :set_author, only: [:update, :destroy]

  def index
    render json: Author.all
  end

  def create
    @author = Author.new(author_params)

    if @author.save
      render json: @author, status: :created
    else
      render json: @author.errors, status: :unprocessable_entity #TODO: encontroar um jeito de destar
    end
  end

  def update
    if @author.update(author_params)
      render json: @author, status: :ok
    else
      render json: @author.errors, status: :unprocessable_entity #TODO: encontroar um jeito de destar
    end
  end

  def destroy
    @author.destroy
    # render json: {'message': 'data deleted successfully'}
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.permit(:name)
  end

end
