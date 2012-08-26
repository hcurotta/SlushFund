class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :merchant_uri
  
  has_secure_password
  
  has_many :funds
end
