get '/' do
  if logged_in?
    redirect 'users/profile'
  else
    erb :landing
  end
end

get '/users/profile' do
  if logged_in?
    erb :profile
  else
    redirect "/"
  end
end

post '/users/logout' do
  session.clear
  redirect '/'
end

post '/users/new' do
  user = User.new(params)
  user.password = params[:password]
  if user.save
    session[:user_id] = User.where(email: user.email).first.id
    redirect '/users/profile'
  else
    redirect '/'
  end
end

post '/users/autho' do
  user = User.where(email: params[:email]).first
  if user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/users/profile'
  else
    redirect '/'
  end
end
