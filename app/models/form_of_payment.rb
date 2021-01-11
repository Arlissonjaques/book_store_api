class FormOfPayment < ApplicationRecord
  has_many :orders
  has_many :clients, through: :orders

  validates :type_payment, presence: true, uniqueness: true
end
