SlushFund::Application.routes.draw do
default_url_options :host => "localhost:3000"  #TODO change to actual site name
root :to => "pages#home"

  get "/login" => 'Sessions#new'
  
  post "/login" => 'Sessions#create'
  delete "/login" => 'Sessions#destroy'

  resources :funds
  get "/funds/:id/contribute" => 'funds#contribute', :as => :contribute
  post "/funds/:id/contribute" => 'funds#checkout', :as => :checkout
  get "/funds/:id/invite" => "Attendees#invite", :as  => :invite
  

  resources :users
  
  

 post "/attendee" => 'Attendees#create', :as => :attendees
 delete "/funds/:fund_id/attendee/:id" => "Attendees#destroy"

 post "/request" => 'Requests#create', :as => :requests
 delete "/funds/:fund_id/request/:id" => "Requests#destroy"

 post "/funds/:fund_id/request/:id/vote_up" => "Requests#vote_up"
 post "/mail/:fund_id" => "Attendees#sendmail"
 post "/mail/reminder/:fund_id" => "Attendees#sendreminder"


end
