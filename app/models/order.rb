class Order < ApplicationRecord
  before_create :generate_order_id

  belongs_to :user 
  has_many :services 

  validates :phone_number, presence: true

  private

  def generate_order_id
    self.order_uniq_id = "UO#{Date.today.strftime("%Y")[2..5]}" + "#{rand.to_s[2..8]}"
  end
end
