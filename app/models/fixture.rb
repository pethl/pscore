class Fixture < ActiveRecord::Base
  attr_accessible :content, :game_id, :hometeam, :awayteam, :matchdate
  belongs_to :game
  validates :game_id, presence: true

  
has_many :predicts
   accepts_nested_attributes_for :predicts
has_many :users, :through => :predicts
  
   default_scope order: 'fixtures.created_at DESC'
   

TEAM_TYPES = ["--", "England", "France", "Ireland", "Italy", "Scotland", "Wales"]
   
def full_fixture
    "#{hometeam} vs. #{awayteam} - #{(matchdate.to_date)}"
  end
   
end
