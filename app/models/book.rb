class Book < ApplicationRecord
  belongs_to :author

  validates :name, :price, presence: true
end
