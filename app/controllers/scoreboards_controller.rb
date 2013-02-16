class ScoreboardsController < ApplicationController
  def index
    @scoreboards = Scoreboard.all
    
    respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @scoreboards }
      end
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
          format.html { redirect_to @scoreboard, notice: 'Result was successfully created.' }
          format.json { render json: @scoreboard, status: :created, location: @scoreboard }
        else
          format.html { render action: "new" }
          format.json { render json: @scoreboard.errors, status: :unprocessable_entity }
        end
      end
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
  
end
