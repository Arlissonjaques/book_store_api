class Api::OrdersController < ApplicationController

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

  private

  def order_params
    params.permit(:client_id, :book_id, :form_of_payment_id)
  end

end
