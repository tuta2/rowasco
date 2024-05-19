class Service < ApplicationRecord
  before_create :add_price
  after_save :update_order_amount
  belongs_to :order

  validates :service_quantity, presence: true

  private

  def add_price
    case service_type
    when "water_supply"
      self.price = 20000
    when "sewage_treatment"
      self.price = 30000
    when "community_forums"
      self.price = 10000
    when "rescue_operations"
      self.price = 15000
    else
      self.price = 5000
    end
  end

  def update_order_amount
    order = Order.find_by(id: self.order_id)
    order.update(total_amount: order.total_amount + self.price)
  end
end
