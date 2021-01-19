class Api::FormOfPaymentsController < ApplicationController

  before_action :set_form_of_payment, only: [:destroy]

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

  def destroy
    @form_of_payment.destroy
    # render json: {'message': 'data deleted successfully'}
  end

  private

  def set_form_of_payment
    @form_of_payment = FormOfPayment.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: :not_found
  end

  def form_of_payment_params
    params.permit(:type_payment)
  end
end
