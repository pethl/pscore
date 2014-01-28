class Game < ActiveRecord::Base
  attr_accessible :name, :startdate, :enddate, :current, :lastyear
  has_many :fixtures, dependent: :destroy
    has_many :predicts
    has_many :scoreboards
    
    default_scope order('startdate DESC')
    
    
    def self.import(file)
       CSV.foreach(file.path, headers: true) do |row|
          Game.create! row.to_hash
      end
    end
    
    
end
