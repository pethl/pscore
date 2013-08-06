class ScoreboardsController < ApplicationController
  
  def index_week
    @scoreboards =   Scoreboard.order("week DESC").limit(10)
      @scoreboard_weeks = @scoreboards.group_by { |t| t.week }
  end
   
  def index
     @scoreboards = get_records.sort_by{ |k, v| v }

     respond_to do |format|
       format.html # index.html.erb
       format.json { render json: @scoreboards }
     end
   end 
    
   def index_match
       @scoreboards = Scoreboard.order("user_id ASC")
        @scoreboards_user = @scoreboards.group_by { |t| t.user_id } 
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
      def get_records
        users = User.all
        scores = Hash.new
        for user in users
          scores[user.id] = Scoreboard.where(:user_id => user.id).sum(:matchscore)
        end
        return scores
      end
  
end
