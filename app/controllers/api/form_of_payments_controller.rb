class Api::FormOfPaymentsController < ApplicationController

  def index
    render json: FormOfPayment.all
  end

  def create
    @form_of_payment = FormOfPayment.new(form_of_payment_params)

    if @form_of_payment.save
      render json: @form_of_payment, status: :created
    else
      render json: @form_of_payment.errors, status: :unprocessable_entity
    end
  end

  private

  def form_of_payment_params
    params.permit(:type_payment)
  end
end
