class Order < ApplicationRecord
  belongs_to :client
  belongs_to :book
  belongs_to :form_of_payment
end
