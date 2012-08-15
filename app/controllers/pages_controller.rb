class PagesController < ApplicationController

def home
  if session[:user_id]
    redirect_to funds_url
  end
  
end


end