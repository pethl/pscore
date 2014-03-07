class ScoreboardsController < ApplicationController
  
  def index_week
    @scoreboards1 = get_records_1.sort_by{ |k, v| v }.reverse
    @scoreboards1_by_score = @scoreboards1.group_by{ |k, v| v }

    @scorebs1 = Scoreboard.where(["week = 1 AND label NOT IN (?)", ["Header","Footer"]]).reverse
    @scorebs1header = Scoreboard.where(:label => "Header", :week => 1)   
    @scorebs1footer = Scoreboard.where(:label => "Footer", :week => 1)   
   
    @scoreboards2 = get_records_2.sort_by{ |k, v| v }.reverse
    @scoreboards2_by_score = @scoreboards2.group_by{ |k, v| v }

    @scorebs2 = Scoreboard.where(["week = 2 AND label NOT IN (?)", ["Header","Footer"]]).reverse
    @scorebs2header = Scoreboard.where(:label => "Header", :week => 2)   
    @scorebs2footer = Scoreboard.where(:label => "Footer", :week => 2)   

    @scoreboards3 = get_records_3.sort_by{ |k, v| v }.reverse
    @scoreboards3_by_score = @scoreboards3.group_by{ |k, v| v }

    @scorebs3 = Scoreboard.where(["week = 3 AND label NOT IN (?)", ["Header","Footer"]]).reverse
    @scorebs3header = Scoreboard.where(:label => "Header", :week => 3)   
    @scorebs3footer = Scoreboard.where(:label => "Footer", :week => 3)   



  end
   
  def index
     @scoreboards = get_records.sort_by{ |k, v| v }.reverse
     @scoreboards_by_score = @scoreboards.group_by{ |k, v| v }

     respond_to do |format|
       format.html # index.html.erb
       format.json { render json: @scoreboards }
     end
   end 
    
   def index_match
      @current_game = Game.where(current: [true])
       @predicts = Predict.where(:game_id => @current_game[0].id)
       @predicts = @predicts.order("user_id ASC")
        @predicts_by_user = @predicts.group_by { |t| t.user_id } 
            @fixtures = Fixture.all
    end
   
  # GET /scoreboards/1
  # GET /scoreboards/1.json
  def show
    @scoreboard = Scoreboard.find(params[:id])
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
    # this calculates the users total points for the competition in the current year - for the scoreboard index
      def get_records
        users = User.all
        game_id = Game.where(:current => true)
        scores = Hash.new
        for user in users
          scores[user.id] = Predict.where(:user_id => user.id, :game_id => game_id).sum(:points)
        end
        return scores
      end
  
       def get_records_1
          users = User.all
          @current_game = Game.where(current: [true])
           @weekfix = Fixture.where(:game_id => @current_game[0].id, :week => 1).select(:id)
          scores = Hash.new
          for user in users
            scores[user.id] = Predict.where(:user_id => user.id, :fixture_id => @weekfix).sum(:points)
          end
          return scores
        end
        
         def get_records_2
            users = User.all
            @current_game = Game.where(current: [true])
            @weekcount = [1,2]
             @weekfix = Fixture.where(:game_id => @current_game[0].id, :week => @weekcount).select(:id)
            scores = Hash.new
            for user in users
              scores[user.id] = Predict.where(:user_id => user.id, :fixture_id => @weekfix).sum(:points)
            end
            return scores
          end
          
       def get_records_3
              users = User.all
              @current_game = Game.where(current: [true])
              @weekcount = [1,2,3]
              @weekfix = Fixture.where(:game_id => @current_game[0].id, :week => @weekcount).select(:id)
              scores = Hash.new
              for user in users
                  scores[user.id] = Predict.where(:user_id => user.id, :fixture_id => @weekfix).sum(:points)
              end
              return scores
            end
    
end
