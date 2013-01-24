class User < ActiveRecord::Base
  attr_accessible :admin, :email, :name
  has_many :predicts
end
