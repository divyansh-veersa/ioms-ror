class Product < ApplicationRecord
  validates :name, presence: true
  validates :sku, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :order_items
  has_many :orders, through: :order_items

  scope :active, -> { where(status: true) }
  scope :inactive, -> { where(status: false) }
  scope :low_stock, -> { where("stock_quantity < ?", 10) }
  scope :out_of_stock, -> { where(stock_quantity: 0) }

  def update_stock(quantity)
    update(stock_quantity: stock_quantity - quantity) if quantity <= stock_quantity
  end
end
