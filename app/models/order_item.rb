class OrderItem < ApplicationRecord
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :product_has_sufficient_stock, on: :create

  belongs_to :order
  belongs_to :product

  before_validation :set_unit_price, on: :create
  after_create :update_product_stock

  def subtotal
    unit_price * quantity
  end

  private

  def set_unit_price
    self.unit_price = product.price if product.present? && unit_price.nil?
  end

  def update_product_stock
    product.update_stock(quantity) if product.present?
  end

  def product_has_sufficient_stock
    if product.present? && quantity.present? && quantity > product.stock_quantity
      errors.add(:quantity, "exceeds available stock (#{product.stock_quantity} available)")
    end
  end
end
