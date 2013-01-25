class User < ActiveRecord::Base
  attr_accessible :admin, :email, :name, :password, :password_confirmation
  has_secure_password
  has_many :predicts
  
   before_save { |user| user.name = name.downcase }
  
  validates :name, presence: true, 
                   length: { maximum: 50 }, 
                   uniqueness: { case_sensitive: false }
  
 
  validates :password, presence: true, length: { minimum: 6 }
    validates :password_confirmation, presence: true
 
end
