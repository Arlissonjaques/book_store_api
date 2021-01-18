class Api::ClientsController < ApplicationController

  before_action :set_client, only: [:update, :destroy]

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

  def update
    if @client.update(client_params)
      render json: @client, status: :ok
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @client.destroy
    # render json: {'message': 'data deleted successfully'}
  end

  private

  def set_client
    @client = Client.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: :not_found
  end

  def client_params
    params.permit(:firstname, :lastname, :email)
  end

end