class Api::ClientsController < ApplicationController

  def index
    render json: Client.all
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      render json: @client, status: :created
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  private

  def client_params
    params.permit(:firstname, :lastname, :email)
  end

end