class Predict < ActiveRecord::Base
  attr_accessible :awayscore, :homescore, :points, :user_id, :fixture_id, :game_id, :correct_result
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
   
   
   
   private
    def get_game_id
      fid = self.fixture_id
      f = Fixture.find(fid)
      gid = f.game_id
      self.game_id = gid
   end
 
   
end
