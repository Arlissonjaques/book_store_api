class Book < ApplicationRecord
  belongs_to :author

  validates :name, :price, presence: true
  validates_numericality_of :price
end
