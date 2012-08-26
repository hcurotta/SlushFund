class FundsController < ApplicationController
  # GET /funds
  # GET /funds.json
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
    fund = Fund.find_by_id(params[:fund_id])
    amount = params[:amount]
     
    recipients = [{:email => 'slushfundmailer@gmail.com',  #remove this recipient if you want it to go to only one receiver
                           :amount => amount.to_f * 0.01, 
                           :primary => false},
                  {:email => fund.user.email, #the organiser of the fund...The user email must match the paypal account email
                   :amount => amount.to_f  * 0.99, #amount less service fee
                   :primary => false}
                   ]
    response = Gateway.setup_purchase(          # TODO Fix the disable_ssl workaround
      :return_url => url_for(:action => 'contribute', :only_path => false),
      :cancel_url => url_for(:action => 'contribute', :only_path => false),
      :ipn_notification_url => url_for(:action => 'contribute', :only_path => false),
      :receiver_list => recipients
    )

    # For redirecting the customer to the actual paypal site to finish the payment.
    redirect_to (Gateway.redirect_url_for(response["payKey"]))
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