SlushFund::Application.routes.draw do

root :to => "pages#home"

  get "/login" => 'Sessions#new'
  
  post "/login" => 'Sessions#create'
  delete "/login" => 'Sessions#destroy'

  resources :funds
  get "/funds/:id/contribute" => 'funds#contribute', :as => :contribute
  post "/funds/:id/contribute" => 'funds#checkout', :as => :checkout

  resources :users
  
  

 post "/attendee" => 'Attendees#create', :as => :attendees
 delete "/fund/:fund_id/attendee/:id" => "Attendees#destroy"

 post "/request" => 'Requests#create', :as => :requests
 delete "/fund/:fund_id/request/:id" => "Requests#destroy"



end
