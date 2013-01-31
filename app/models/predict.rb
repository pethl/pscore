class Predict < ActiveRecord::Base
  attr_accessible :awayscore, :homescore, :points, :user_id, :fixture_id, :game_id
   belongs_to :user
   belongs_to :game
   belongs_to :fixtures
   has_one :fixture

   
   def  get_fixture
     r = self.fixture_id
     @fix1 = Fixture.find(r)
     x = @fix1.hometeam + " vs " + @fix1.awayteam
     end
   
   
end
