class Board < ActiveRecord::Base
  attr_accessible :game_id, :user_id, :year
  validates :year, :presence => true
  validates :game_id, :presence => true
  validates :user_id, :presence => true
end
