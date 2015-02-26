class ScoreboardsController < ApplicationController
    before_filter :admin_user,   only: [:show, :edit  ]
  
  def index_week
    # need to build a new set of scoring pages for 2015s
    @scoreboards_1_2015 = Scoreboard.where(:game_id => 5, :week => 1)
    @user_scores_1_2015 = get_records_2015(1).sort_by{ |k, v| v }.reverse
    @user_scores_1_2015 = @user_scores_1_2015.group_by{ |k, v| v }
    
    @scoreboards_2_2015 = Scoreboard.where(:game_id => 5, :week => 2)
    @week = [1,2]
    @user_scores_2_2015 = get_records_2015(@week).sort_by{ |k, v| v }.reverse
    @user_scores_2_2015 = @user_scores_2_2015.group_by{ |k, v| v }
  end
    
  def scores_2014
    # all this code is for 2014 only - due to horrid format of text
   
    @scoreboards = get_records_2014.sort_by{ |k, v| v }.reverse
    @scoreboards_by_score = @scoreboards.group_by{ |k, v| v }
    
    @scoreboards_2014 = Scoreboard.where(:game_id => 4)
    
    @scoreboards1 = get_records_1.sort_by{ |k, v| v }.reverse
    @scoreboards1_by_score = @scoreboards1.group_by{ |k, v| v }

    @scorebs1 = @scoreboards_2014.where(["week = 1 AND label NOT IN (?)", ["Header","Footer"]]).reverse
    @scorebs1header = @scoreboards_2014.where(:label => "Header", :week => 1)   
    @scorebs1footer = @scoreboards_2014.where(:label => "Footer", :week => 1)   
   
    @scoreboards2 = get_records_2.sort_by{ |k, v| v }.reverse
    @scoreboards2_by_score = @scoreboards2.group_by{ |k, v| v }

    @scorebs2 = @scoreboards_2014.where(["week = 2 AND label NOT IN (?)", ["Header","Footer"]]).reverse
    @scorebs2header = @scoreboards_2014.where(:label => "Header", :week => 2)   
    @scorebs2footer = @scoreboards_2014.where(:label => "Footer", :week => 2)   

    @scoreboards3 = get_records_3.sort_by{ |k, v| v }.reverse
    @scoreboards3_by_score = @scoreboards3.group_by{ |k, v| v }

    @scorebs3 = @scoreboards_2014.where(["week = 3 AND label NOT IN (?)", ["Header","Footer"]]).reverse
    @scorebs3header = @scoreboards_2014.where(:label => "Header", :week => 3)   
    @scorebs3footer = @scoreboards_2014.where(:label => "Footer", :week => 3)   

    @scoreboards4 = get_records_4.sort_by{ |k, v| v }.reverse
    @scoreboards4_by_score = @scoreboards4.group_by{ |k, v| v }

    @scorebs4 = @scoreboards_2014.where(["week = 4 AND label NOT IN (?)", ["Header","Footer"]]).reverse
    @scorebs4header = @scoreboards_2014.where(:label => "Header", :week => 4)   
    @scorebs4footer = @scoreboards_2014.where(:label => "Footer", :week => 4)   
    
    @scoreboards5 = get_records_5.sort_by{ |k, v| v }.reverse
    @scoreboards5_by_score = @scoreboards5.group_by{ |k, v| v }
    
    @scorebs5 = @scoreboards_2014.where(["week = 5 AND label NOT IN (?)", ["Header","Footer"]]).reverse
    @scorebs5header = @scoreboards_2014.where(:label => "Header", :week => 5).order("id ASC")    
    @scorebs5footer = @scoreboards_2014.where(:label => "Footer", :week => 5)

  end
   
  def index # this view is simple running total of points scores by users, once the competition has started
     @scoreboards = get_records.sort_by{ |k, v| v }.reverse
     @scoreboards_by_score = @scoreboards.group_by{ |k, v| v }

     respond_to do |format|
       format.html # index.html.erb
       format.json { render json: @scoreboards }
     end
   end 
    
   def index_match #this page selects only those players with predictions in this current game year
   
      @current_game = Game.where(current: [true])
       @predicts = Predict.where(:game_id => @current_game[0].id)
       @predicts = @predicts.order("user_id ASC")
        @predicts_by_user = @predicts.group_by { |t| t.user_id } 
 
    end
   
  # GET /scoreboards/1
  # GET /scoreboards/1.json
  def show
    @scoreboard = Scoreboard.find(params[:id])
  end
 
  def edit
    @scoreboard = Scoreboard.find(params[:id])
         @games = Game.all
  end
 
  def new
        @scoreboards = Scoreboard.all
     @scoreboard = Scoreboard.new
     @games = Game.all

     respond_to do |format|
       format.html # new.html.erb
       format.json { render json: @scoreboard }
     end
   end
  
   def create
      @scoreboard = Scoreboard.new(params[:scoreboard])

      respond_to do |format|
        if @scoreboard.save
          format.html { redirect_to @scoreboard, notice: 'Score record was successfully created.' }
          format.json { render json: @scoreboard, status: :created, location: @scoreboard }
        else
          format.html { render action: "new" }
          format.json { render json: @scoreboard.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def generate
      @f = (params[:fixture])
      fixture = @f["fixture_id"]
        Scoreboard.generate(fixture)
        redirect_to scoreboards_path, notice: "Score records were generated."
    end
  
    # DELETE /scoreboards/1
    # DELETE /scoreboards/1.json
    def destroy
      @scoreboard = Scoreboard.find(params[:id])
      @scoreboard.destroy

      respond_to do |format|
        format.html { redirect_to scoreboards_url }
        format.json { head :no_content }
      end
    end
    
    def update
      @scoreboard = Scoreboard.find(params[:id])

      respond_to do |format|
        if @scoreboard.update_attributes(params[:scoreboard])
          format.html { redirect_to @scoreboard, notice: 'Scoreboard was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @scoreboard.errors, status: :unprocessable_entity }
        end
      end
    end
  
    private
    
    #find all the users who had predictions in a given year, not all players play every year
    def players_by_year(game_id)
     @users = User.all
     @players_by_year = [] #empty hash to add only user ids where predicition records are found

     #iterate through users and if predicts count greater than 0, add id to hash
      @users.each do |user|
         predicts  = Predict.where(:game_id => game_id, :user_id => user.id)
          if predicts.count > 0
            @players_by_year << (user.id)
          end        
       end
       return @players_by_year
   end    
    
    # this calculates the users total points for the competition in the current year - for the scoreboard index
      def get_records
        game_id = Game.where(:current => true)
        users = players_by_year(game_id)    
        scores = Hash.new
        
        for user in users
          @predicts = Predict.where(:game_id => game_id, :user_id => (user))
              if @predicts.count > 0
                  scores[user] = Predict.where(:user_id => user, :game_id => game_id[0].id).sum(:points)
              end 
        end
        
        return scores
      end
      
      def get_records_2015(week)  # get user scores per week by passing in week, note year is fixed
         
         game_id = 5
         users = players_by_year(game_id)
         scores = Hash.new
          @weekfix = Fixture.where(:game_id => game_id, :week => week).select(:id)
          Rails.logger.debug("fixture count: #{@weekfix.count}") 
         for user in users
           scores[user] = Predict.where(:user_id => user, :fixture_id => @weekfix).sum(:points)
         end
         return scores
       end  
      
      
       def get_records_2014
          game_id = 4
          users = players_by_year(game_id)
          scores = Hash.new
          for user in users
            scores[user] = Predict.where(:user_id => user, :game_id => game_id).sum(:points)
          end
          return scores
        end

      # these calcs get the users total points for each specified week in 2014- for the Scoreboard by week results page  
       def get_records_1
          game_id = 4 # 2014 game_id
          users = players_by_year(game_id) 
           @weekfix = Fixture.where(:game_id => game_id, :week => 1).select(:id)
          scores = Hash.new
          for user in users
            scores[user] = Predict.where(:user_id => user, :fixture_id => @weekfix).sum(:points)
          end
          return scores
        end
        
       def get_records_2
          game_id = 4 # 2014 game_id
          users = players_by_year(game_id)
          @weekcount = [1,2]
           @weekfix = Fixture.where(:game_id => game_id, :week => @weekcount).select(:id)
          scores = Hash.new
          for user in users
            scores[user] = Predict.where(:user_id => user, :fixture_id => @weekfix).sum(:points)
          end
          return scores
        end
          
       def get_records_3
              game_id = 4 # 2014 game_id
              users = players_by_year(game_id)
              @weekcount = [1,2,3]
              @weekfix = Fixture.where(:game_id => game_id, :week => @weekcount).select(:id)
              scores = Hash.new
              for user in users
                  scores[user] = Predict.where(:user_id => user, :fixture_id => @weekfix).sum(:points)
              end
              return scores
            end
    
      def get_records_4
             game_id = 4 # 2014 game_id
             users = players_by_year(game_id)
             @weekcount = [1,2,3,4]
             @weekfix = Fixture.where(:game_id => game_id, :week => @weekcount).select(:id)
             scores = Hash.new
             for user in users
                 scores[user] = Predict.where(:user_id => user, :fixture_id => @weekfix).sum(:points)
             end
             return scores
           end  
           
       def get_records_5
          game_id = 4 # 2014 game_id
          users = players_by_year(game_id)
          scores = Hash.new
          for user in users
            scores[user] = Predict.where(:user_id => user, :game_id => game_id).sum(:points)
          end
          return scores
        end      
end
