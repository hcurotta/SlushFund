class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :merchant_uri
  
  has_secure_password
  
  has_many :funds
  
  def pay_out_existing
    
    if self.amount_in_escrow > 0
    
      amount_in_cents = self.amount_in_escrow*100
      user_account = Balanced::Account.find(self.merchant_uri)
      slushfund = Balanced::Marketplace.my_marketplace

    
      if amount_in_cents > 1000
          user_account.credit(amount_in_cents*0.95)
          slushfund.owner_account.credit(amount_in_cents*0.05)
          self.amount_in_escrow = 0
          self.save
      else
          user_account.credit(amount_in_cents)
          self.amount_in_escrow = 0
          self.save
      end
    end
  end
end
