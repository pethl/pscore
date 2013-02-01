class Predict < ActiveRecord::Base
  attr_accessible :awayscore, :homescore, :points, :user_id, :fixture_id, :game_id
   belongs_to :user
   belongs_to :game
   belongs_to :fixtures
   has_one :fixture

   
  
   
   
end
