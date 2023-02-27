class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable, :jwt_authenticatable, jwt_revocation_strategy: self

  validates :email, presence: true
  validates :username, presence: true

  def jwt_payload
    super
  end
end
