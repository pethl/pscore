class User < ActiveRecord::Base
  attr_accessible :admin, :email, :name, :password-digest, :remember-token
end
