class Fixture < ActiveRecord::Base
  attr_accessible :content, :game_id, :hometeam, :awayteam, :matchdate, :matchhomescore, :matchawayscore, :ko, :week, :fixresultgap
  belongs_to :game
 
  has_many :predicts
  accepts_nested_attributes_for :predicts
  has_many :users, :through => :predicts

  
  default_scope order: 'fixtures.created_at ASC'
   
  TEAM_TYPES = ["--", "England", "France", "Ireland", "Italy", "Scotland", "Wales"]
   
  def self.import(file)
    row_id = Array.new
     CSV.foreach(file.path, headers: true) do |row|
        rid = Fixture.create! row.to_hash
        row_id << rid.id
      end
      return row_id
  end
  
  
  def self.updaterow(row_id, game)
    row_id.each do |id|
      a = Fixture.find(id)
      Fixture.update(id, :game_id => game)
    end
  end
 
  def full_fixture
    "#{hometeam} vs. #{awayteam} - #{(matchdate.strftime("%d %B, %Y"))}"
  end

  def who_plays_who
    "#{hometeam} vs. #{awayteam}"
  end    
  
end