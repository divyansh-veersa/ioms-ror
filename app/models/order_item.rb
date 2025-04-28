class OrderItem < ApplicationRecord
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :product_has_sufficient_stock, on: :create

  belongs_to :order
  belongs_to :product
end
