class Order < ApplicationRecord
  belongs_to :client
  belongs_to :book
  belongs_to :form_of_payment

  def book_references
    {
      "name": self.book.name,
      "price": self.book.price
    }
  end
end
