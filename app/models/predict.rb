class Predict < ActiveRecord::Base
  attr_accessible :awayscore, :homescore, :points, :user_id
   belongs_to :user
end
