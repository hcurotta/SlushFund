Gateway =  ActiveMerchant::Billing::PaypalAdaptivePayment.new(
    :login => ENV["API_LOGIN"],
    :password => ENV["API_PASSWORD"],
    :signature => ENV["API_SIGNATURE"],
    :appid => ENV["APP_ID"] )