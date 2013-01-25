class User < ActiveRecord::Base
  attr_accessible :admin, :email, :name, :password, :password_confirmation
  has_secure_password
  has_many :predicts
  
   before_save { |user| user.name = name.downcase }
  
  validates :name, presence: true, 
                   length: { maximum: 50 }, 
                   uniqueness: { case_sensitive: false }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }
 
  validates :password, presence: true, length: { minimum: 6 }
    validates :password_confirmation, presence: true
 
end
