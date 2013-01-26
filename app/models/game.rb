class Game < ActiveRecord::Base
  attr_accessible :name, :startdate, :enddate
end
