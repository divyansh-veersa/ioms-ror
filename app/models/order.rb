class Order < ApplicationRecord
  STATUSES = %w[pending processing shipped delivered canceled].freeze

  validates :customer, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :total, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  before_validation :set_default_status, on: :create
  before_save :calculate_total

  scope :pending, -> { where(status: "pending") }
  scope :processing, -> { where(status: "processing") }
  scope :shipped, -> { where(status: "shipped") }
  scope :delivered, -> { where(status: "delivered") }
  scope :canceled, -> { where(status: "canceled") }
  scope :this_month, -> { where(created_at: Time.current.beginning_of_month..Time.current.end_of_month) }

  def process
    update(status: "processing") if status == "pending"
  end

  def ship
    update(status: "shipped") if status == "processing"
  end

  def deliver
    update(status: "delivered") if status == "shipped"
  end

  def cancel
    return false if status == "delivered"

    transaction do
      order_items.each do |item|
        item.product.update(stock_quantity: item.product.stock_quantity + item.quantity)
      end
      update(status: "canceled")
    end
  end

  private

  def set_default_status
    self.status ||= "pending"
  end

  def calculate_total
    self.total = order_items.sum { |item| item.unit_price * item.quantity }
  end
end
