class Client < ApplicationRecord
  has_many :orders
  has_many :form_of_payments, through: :orders
end
