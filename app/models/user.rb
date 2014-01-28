class User < ActiveRecord::Base
  attr_accessible :admin, :email, :name, :password, :password_confirmation, :wins, :style
  has_secure_password
  has_many :predicts
  accepts_nested_attributes_for :predicts
  
  
   before_save { |user| user.name = name.downcase }
    before_save :create_remember_token
  
  validates :name, presence: true, 
                   length: { maximum: 50 }, 
                   uniqueness: { case_sensitive: false }
  
 
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
 
     def self.import(file)
         CSV.foreach(file.path, headers: true) do |row|
            User.create! row.to_hash
        end
      end
 
 
 
 
     def full_fixture
          "#{hometeam} vs. #{awayteam} - #{(matchdate.strftime("%d %B, %Y"))}"
        end
 
    private

        def create_remember_token
          self.remember_token = SecureRandom.urlsafe_base64
        end
        
       
 
end
