require 'balanced'

key = Balanced::ApiKey.new.save
Balanced.configure(key.secret)
Balanced::Marketplace.new.save

puts key.secret