class User < ActiveRecord::Base
  require 'bcrypt'
  include BCrypt
  has_many  :letters
  validates :first_name, :last_name, :password_hash, presence: true
  validates :email,
                    :presence => {:message => "Please Enter a email address!" },
                    :uniqueness => {:case_sensitive => false, :message => "Email already exists!"},
                    :format => { :with => /.+@.+\..+/i, :message => "Enter a valid Email address !"}

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(password)
    self.password == password
  end

end
