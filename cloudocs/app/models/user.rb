class User < ActiveRecord::Base
  has_secure_password
  validates :email, :name, presence: true, uniqueness: true
  validates :password_digest, presence: true      
end
