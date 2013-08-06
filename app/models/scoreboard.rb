class Scoreboard < ActiveRecord::Base
  attr_accessible :comment, :game_id, :position, :week, :user_id, :fixture_id, :matchscore
  
  belongs_to :game
   validates :game_id, presence: true
   
   WEEK_TYPES = ["--", "1", "2", "3", "4", "5"]
   POSITION_TYPES = ["--", "1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th"]
   
   
     def self.generate(fixture_id)
       
       # get game id from fixture
       game = Fixture.find(fixture_id).game_id
       Rails.logger.debug("game in model: #{game.inspect}")
       
       # get week from fixture
       week = Fixture.find(fixture_id).week
       Rails.logger.debug("week in model: #{week.inspect}")
       
         @users = User.pluck(:id)
         t = 0
         @users.each do |user|

             q = Scoreboard.new(:fixture_id => fixture_id, :user_id => user, :matchscore => 0,  :game_id => game, :week => week)
             q.save
             Rails.logger.debug("new id is: #{q.id.inspect}")
         end
       end
   
   
   
end
