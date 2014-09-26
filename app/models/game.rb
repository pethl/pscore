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
    
    def self.get_last_four_years
       @games = Game.where(current: [false, nil])
        @lastfour = []
        
          @games.each do |game|
            if game.startdate >= Date.today-1420
                 @lastfour << game
            end
            
          end
              
         return @lastfour
      end
    
      def game_details
        "#{name} - #{(startdate.strftime("%d %B, %Y"))}"
      end
    
    
end
