get '/' do
  if logged_in?
    redirect '/users/profile'
  else
    erb :landing
  end
end

get '/users/profile' do
  @lob = Lob.load(api_key: "test_cd149f37b86b109033dd4c639a99bc18584")
  if logged_in?
    @current_user = current_user
    @current_user.addresss
    if @current_user.addresss
       @user_address = @lob.addresses.find(@current_user.addresss)
    end
    erb :profile
  else
    redirect "/"
  end
end

post '/users/profile' do 
  Stripe.api_key = "sk_test_s8FghPjfshIHujtzhTZOjz8N"
  token = params[:stripeToken]
  customer = Stripe::Customer.create(
    :source => token,
    :description => "payinguser@example.com"
  )
  current_user.update_attributes(payment_id: customer.id)
end

post 'user/letter/send' do
  # @lob = Lob.load(api_key: "test_cd149f37b86b109033dd4c639a99bc18584")
  # customer_id = current_user.payment_id
  # @lob.jobs.create(
  #   name: "letter share",
  #   from: current_user.addresss,
  #   to: #have to figure out logic for this
  #   object: #have to create an object then refrence it for every user
  # )
  # Stripe::Charge.create(
  #   :amount   => 1500,
  #   :currency => "usd",
  #   :customer => customer_id
  # )
end

post '/users/address/add' do 
  @lob = Lob.load(api_key: "test_cd149f37b86b109033dd4c639a99bc18584")
  address = {
    address_line1:    params[:address_line1],
    address_line2:    params[:address_line2],
    address_city:     params[:city],
    address_state:    params[:state],
    address_zip:      params[:zip],
    address_country:  params[:country],
  }
  refined_address = @lob.addresses.verify(address)
  refined_address = refined_address["address"]
  userAddress = @lob.addresses.create(
    name:           params[:full_name],
    email:          current_user.email,
    address_line1:  refined_address["address_line1"],
    address_line2:  refined_address["address_line2"],
    city:           refined_address["address_city"],
    state:          refined_address["address_state"],
    zip:            refined_address["address_zip"],
    country:        refined_address["address_country"],
  )
  current_user.update_attributes(:addresss => userAddress["id"])
  content_type :json
  message = "hey"
  message.to_json
end


