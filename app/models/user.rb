class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_secure_token :auth_token
  has_many :orders
  has_many :purchased_records, -> { purchased }, class_name: :Order
  
  enum role: { member: 0, admin: 1 }

  def renew_token!
    regenerate_auth_token
    auth_token
  end
end
