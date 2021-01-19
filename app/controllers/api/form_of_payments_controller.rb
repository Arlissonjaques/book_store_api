class Api::FormOfPaymentsController < ApplicationController

  def index
    render json: FormOfPayment.all
  end
end
