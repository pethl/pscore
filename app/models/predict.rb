class Predict < ActiveRecord::Base
  attr_accessible :awayscore, :homescore, :points, :user_id, :fixture_id, :game_id, :nearest_margin, :right_result, :closest_to_home, :closest_to_away, :exact_home_score, :exact_away_score, :exact_result, :val_right_result, :val_closest_to_home, :val_closest_to_away, :val_exact_result, :new 
   belongs_to :user
   belongs_to :game
   belongs_to :fixtures
   has_one :fixture
   
   
   before_save :get_game_id
   validates_length_of :homescore, :maximum => 3
   validates_length_of :awayscore, :maximum => 3
   
     def self.import(file)
       row_id = Array.new
        CSV.foreach(file.path, headers: true) do |row|
           rid = Predict.create! row.to_hash
           row_id << rid.id
           Rails.logger.debug("rid: #{row_id.inspect}")
         end
         return row_id
     end
   
     def self.updaterow(row_id, game)
       Rails.logger.debug("in update row method_rid: #{row_id.inspect}")
       row_id.each do |id|
         a = Predict.find(id)
         Predict.update(id, :game_id => game)
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
