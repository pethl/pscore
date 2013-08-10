class Predict < ActiveRecord::Base
  attr_accessible :awayscore, :homescore, :points, :user_id, :fixture_id, :game_id, :correct_result, :right_result, :closest_to_home, :closest_to_away, :exact_home_score, :exact_away_score, :exact_result, :val_right_result, :val_closest_to_home, :val_closest_to_away, :val_exact_result 
   belongs_to :user
   belongs_to :game
   belongs_to :fixtures
   has_one :fixture
   
   
   before_save :get_game_id
   
     def self.import(file)
        CSV.foreach(file.path, headers: true) do |row|
           Game.create! row.to_hash
       end
     end
   
     def total_score  #no longer used as calc written to database in fixtures_controller, left as example
       total_score = self.closest_to_home.to_i + self.closest_to_away.to_i + self.right_result.to_i + self.exact_home_score.to_i + self.exact_away_score.to_i + self.exact_result.to_i
     end
   
   private
    def get_game_id
      fid = self.fixture_id
      f = Fixture.find(fid)
      gid = f.game_id
      self.game_id = gid
   end
 
   
end
