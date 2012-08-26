SlushFund::Application.routes.draw do
default_url_options :host => "localhost:3000"  #TODO change to actual site name

get "/funds/confirm/" => "funds#confirm_pay"


root :to => "pages#home"

  get "/login" => 'Sessions#new'
  get "/cardtest" => 'Pages#card_test'
  
  post "/login" => 'Sessions#create'
  delete "/login" => 'Sessions#destroy'
  
  get "users/:id/setup_bank" => "Users#merchant_details", :as => :setup_bank
  get "/user/:id/save_bank/" => "Users#save_bank"



  resources :funds
  get "/funds/:id/contribute" => 'funds#contribute', :as => :contribute
  get "/funds/:id/checkout" => 'funds#checkout', :as => :checkout
  post "/funds/:id/checkout" => 'funds#execute_payment', :as => :execute_payment
  
  get "/funds/:id/invite" => "Attendees#invite", :as  => :invite
  

  resources :users
  
  

  
  

 post "/attendee" => 'Attendees#create', :as => :attendees
 delete "/funds/:fund_id/attendee/:id" => "Attendees#destroy"

 post "/request" => 'Requests#create', :as => :requests
 delete "/funds/:fund_id/request/:id" => "Requests#destroy"

 post "/funds/:fund_id/request/:id/vote_up" => "Requests#vote_up"
 post "/mail/:fund_id" => "Attendees#sendmail"


end
