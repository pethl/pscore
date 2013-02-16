class Scoreboard < ActiveRecord::Base
  attr_accessible :comment, :game_id, :position, :week
  
  belongs_to :game
   validates :game_id, presence: true
   
   WEEK_TYPES = ["--", "1", "2", "3", "4", "5"]
   POSITION_TYPES = ["--", "1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th"]
   
end
