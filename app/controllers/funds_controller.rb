class FundsController < ApplicationController
require "open-uri"
  # GET /funds
  # GET /funds.json
  before_filter :require_session , :only => [:index, :new, :edit, :create, :update, :destroy]
  before_filter :require_match , :only => [:edit, :destroy]
  
  def require_session   #must be logged in.  These don't require a match because actions are based off their session[:user_id]
    if !session[:user_id]
      redirect_to root_url, :notice => "You must be logged in to see that!"
    end
  end
  def require_match   #edit page can be accessed via URL so make sure the fund they try to access is one of theirs
    if !User.find(session[:user_id]).funds.include?(Fund.find(params[:id]))
      redirect_to root_url , :notice => "You don't have permission to do that!"
    end
  end
  
  
  
  def index
   if session[:user_id]
    @user = User.find(session[:user_id])
      @funds = @user.funds
    else
      @funds = Fund.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @funds }
    end
  end

  # GET /funds/1
  # GET /funds/1.json
  def show
    cookies[:email] = params[:email] if params[:email]
    
    @fund = Fund.find(params[:id])
    @user = User.find_by_id(@fund.user_id)
    
    if @user.id == session[:user_id]
      @owner = true
    else
      @owner = false
    end
    
    @request = Request.new
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fund }
    end
  end
  
  def contribute

  end
  
  def checkout
    
    #This bit of code creates a 'buyer' account on Balanced. This is required before a card can be charged.
    
    @fund = Fund.find_by_id(params[:id])
    amount = params[:amount]
    
    @card_uri = params[:card_uri]
    email_address = params[:email]

    # for a new account
    begin
    @buyer = Balanced::Marketplace.my_marketplace.create_buyer(
               email_address,
               @card_uri)

    # ERROR Catching
    rescue Balanced::Conflict => ex
      puts "EX CATEGORY: " +ex.category_code
      if ex.category_code == 'duplicate-email-address'
        
          @buyer = Balanced::Account.find ex.extras[:account_uri]
      
          new_card = Balanced::Credit.find(@card_uri)
          
          # Using the REST Api here rather than the Gem because the Gem is buggy
          # Getting all cards associated with the account to check if the last 4 and exp match
          cards = open("https://api.balancedpayments.com/#{@buyer.uri}/cards", :http_basic_authentication => ["9c882970f00911e1afad026ba7e5e72e"]).read

          cards = JSON.parse(cards)
          
          existing_card = false

          cards["items"].each do |card|
        
             if card["card_type"] == new_card.card_type and card["last_four"] == new_card.last_four and card["expiration_month"] == new_card.expiration_month and card["expiration_year"] == new_card.expiration_year
               puts card["uri"]
               @buyer = Balanced::Credit.find(card["uri"])
               puts 'im here'
               existing_card = true
             end
         
          end
          
          @buyer = @buyer.add_card @card_uri unless existing_card == true 
          
          
        else
        render text: ex + ". This card is registered to a different email"
        end

    rescue Balanced::BadRequest => ex
      # what exactly went wrong?
      puts ex
      raise
    end
  end
  
  def execute_payment
    
    buyer = Balanced::Credit.find(params[:card_uri])
    puts "####################BUYER "+buyer.inspect
    puts "####################CARD URI "+params[:card_uri]
    # debit = buyer.debit(200,'test')
    
    fund = Fund.find_by_id(params[:id])

    description = "SlushFund "+fund.name
    description = description.slice(0..21) #txn description must be less than 22 characters
    
    amount_in_cents = params[:amount].to_i*100  # $10.00 USD
    debit = buyer.debit(amount_in_cents, description) 
    
    attendee = Attendee.find_by_email(params[:email])
    attendee.paid = TRUE
    attendee.save
    
    organizer_account = Balanced::Account.find(fund.user.merchant_uri)
    slushfund = Balanced::Marketplace.find("/v1/marketplaces/TEST-MP4LvXOqy535KaKJqLwcIUMy/")
    # slushfund = Balanced::Marketplace.my_marketplace
    
    organizer_account.credit(amount_in_cents*0.95)
    slushfund.owner_account.credit(amount_in_cents*0.05)
    
    redirect_to "/funds/#{fund.id}", notice: 'Thanks for paying!'
    
end

  # GET /funds/new
  # GET /funds/new.json
  def new
    @fund = Fund.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fund }
    end
  end

  # GET /funds/1/edit
  def edit
    @fund = Fund.find(params[:id])
  end

  # POST /funds
  # POST /funds.json
  def create
    @fund = Fund.new(params[:fund])
    @fund.user_id = session[:user_id]

    respond_to do |format|
      if @fund.save
        format.html { redirect_to "/funds/#{@fund.id}/invite", notice: 'Fund was successfully created.' }
        format.json { render json: @fund, status: :created, location: @fund }
      else
        format.html { render action: "new" }
        format.json { render json: @fund.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /funds/1
  # PUT /funds/1.json
  def update
    @fund = Fund.find(params[:id])

    respond_to do |format|
      if @fund.update_attributes(params[:fund])
        format.html { redirect_to @fund, notice: 'Fund was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fund.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /funds/1
  # DELETE /funds/1.json
  def destroy
    @fund = Fund.find(params[:id])
    @fund.destroy

    respond_to do |format|
      format.html { redirect_to funds_url }
      format.json { head :no_content }
    end
  end
  

  
end