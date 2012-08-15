class SessionsController < ApplicationController
  
  def new
    
  end
  
  def create
    user = User.find_by_email(params[:email])
     if user
          if user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to funds_url, :notice => "Welcome back, #{user.name}!"
          else
            redirect_to "/login", :notice => "The password you entered is incorrect!"
          end
     else
        redirect_to "/login", :notice => "The email address could not be found!"    
     end


     end

     def destroy
       session[:user_id] = nil
       redirect_to root_url, :notice => "You've successfully signed out."
     end
end
