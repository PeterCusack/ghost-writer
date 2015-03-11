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
