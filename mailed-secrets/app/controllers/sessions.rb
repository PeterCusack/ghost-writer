post '/users/autho' do
  user = User.where(email: params[:email]).first
  if user
    if user.authenticate(params[:password]) 
      session[:user_id] = user.id
      redirect '/users/profile'
    else
      redirect '/'
    end
  else 
    redirect '/'
  end
end

post '/users/logout' do
  session.clear
  redirect '/'
end

get '/users/authorize/facebook' do 
  redirectURI = URI("http://fuf.me:9393/users/authorize/facebook")
  response = HTTParty.post("https://graph.facebook.com/oauth/access_token?client_id=583264651809192&redirect_uri=#{redirectURI}&client_secret=ec7e86599adee3a7be48f35c60e9ce45&code=#{params[:code]}")
  token = Rack::Utils.parse_nested_query(response.body)
  @graph = Koala::Facebook::API.new(token["access_token"])
  if !(User.where(email: @graph.get_object("me")["email"]).first)
    # create_and_validate 
    user = User.new({
      first_name: @graph.get_object("me")["first_name"],
      last_name:  @graph.get_object("me")["last_name"],
      email:      @graph.get_object("me")["email"],
      })
    if user.save
        session[:user_id] = User.where(email: user.email).first.id
        redirect '/users/profile'
    else 
      @errors = user.errors.full_messages
      redirect '/'
    end
  else 
    session[:user_id] = User.where(email: @graph.get_object("me")["email"]).first.id
    redirect '/users/profile'
  end
  # redirect with an error that something went wrong
end


post '/users/new' do
  user = User.new(
    first_name: params[:first_name],
    last_name: params[:last_name],
    email: params[:email],
    )
  user.password = params[:password]
  if user.save && params[:password] == params[:repassword]
    session[:user_id] = User.where(email: user.email).first.id
    redirect '/users/profile'
  else
    @errors = user.errors.full_messages
    redirect '/'
  end
end
