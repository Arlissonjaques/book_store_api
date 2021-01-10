class Client < ApplicationRecord
  has_many :orders
  has_many :form_of_payments, through: :orders

  validates :firstname, :lastname, presence: true
  validates_format_of :email, :with => /\A[^@\s]+@[^@\s]+\z/
end
