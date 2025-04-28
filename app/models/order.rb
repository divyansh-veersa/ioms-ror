class Order < ApplicationRecord
  STATUSES = %w[pending processing shipped delivered canceled].freeze

  validates :customer, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :total, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  scope :pending, -> { where(status: "pending") }
  scope :processing, -> { where(status: "processing") }
  scope :shipped, -> { where(status: "shipped") }
  scope :delivered, -> { where(status: "delivered") }
  scope :canceled, -> { where(status: "canceled") }
  scope :this_month, -> { where(created_at: Time.current.beginning_of_month..Time.current.end_of_month) }
end
