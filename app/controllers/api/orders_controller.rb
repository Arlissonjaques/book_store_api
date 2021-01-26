class Api::OrdersController < ApplicationController

  before_action :set_order, only: [:destroy]

  def index
    render json: Order.all
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      render json: @order, status: :created
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params)
      render json: @order, status: :ok
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.permit(:client_id, :book_id, :form_of_payment_id)
  end

end
