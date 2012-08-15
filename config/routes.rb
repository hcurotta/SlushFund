SlushFund::Application.routes.draw do

root :to => "pages#home"

  get "/login" => 'Sessions#new'
  
  post "/login" => 'Sessions#create'
  delete "/login" => 'Sessions#destroy'

  resources :funds

  resources :users

 post "/attendee" => 'Attendees#create', :as => :attendees
 delete "/fund/:fund_id/attendee/:id" => "Attendees#destroy"

end
