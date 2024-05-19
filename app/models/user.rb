class User < ApplicationRecord
  has_secure_password
  has_many :orders

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: {with: URI::MailTo::EMAIL_REGEXP}
  # validates :phone_number, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  default_scope {order('users.created_at DESC')}

  Roles = [:super_admin , :admin, :customer]

  def is?( requested_role )
    self.role == requested_role.to_s
  end

end
