class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        UserMailer.registration_confirmation(@user).deliver
        format.html { redirect_to funds_url, notice: "You've successfully signed up!" }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
  def merchant_details
    @user = User.find(session[:user_id])
    
  end
  
  def save_bank
    @user = User.find(session[:user_id])

    begin
          merchant = Balanced::Marketplace.my_marketplace.create_merchant(
              @user.email,
              {
                :type => "person",
                :name => params[:full_name],
                :street_address => params[:street],
                :postal_code => params[:zip],
                :region => params[:state],
                :country => "USA",
                :dob => params[:dob],
                :phone_number => params[:phone_number],
              },
              params[:merchant_uri],
              @user.name,
          )
          
          @user.merchant_uri = params[:merchant_uri]
          @user.save
          redirect_to new_fund_path
        rescue Balanced::Conflict => ex
          # handle the conflict here..
          render text: "conflict"
        rescue Balanced::BadRequest => ex
          render text: "bad data"
        rescue Balanced::MoreInformationRequired => ex
          # merchant[type]=personal&merchant[phone_number]=#{params[:phone_number]}&
      redirect_to ex.redirect_uri + "?redirect_uri=" + "http://localhost:3000/funds/&merchant[type]=personal&merchant[email]=#{@user.email}"
    end
  end
  
end
