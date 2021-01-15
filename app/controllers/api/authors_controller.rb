class Api::AuthorsController < ApplicationController
  def index
    render json: Author.all
  end
end
