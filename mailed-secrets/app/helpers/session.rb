helpers do
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def create_and_validate(user_hash)
  	User.new(
  		first_name: user_hash["first_name"],
  		last_name: 	user_hash["last_name"],
  		email: 		user_hash["email"]
  		)
  	User.save
  end
end
