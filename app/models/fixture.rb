class Fixture < ActiveRecord::Base
  attr_accessible :content, :game_id, :hometeam, :awayteam, :matchdate
  belongs_to :game
  validates :game_id, presence: true
  
   default_scope order: 'fixtures.created_at DESC'
   

TEAM_TYPES = ["--", "England", "France", "Ireland", "Italy", "Scotland", "Wales"]
   
   
end
