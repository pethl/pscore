class Game < ActiveRecord::Base
  attr_accessible :name, :startdate, :enddate
  has_many :fixtures, dependent: :destroy
    has_many :predicts
end
