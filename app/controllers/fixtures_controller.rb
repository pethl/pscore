class FixturesController < ApplicationController

    # GET /fixtures
    # GET /fixtures.json
    def index
       #   @fixtures = Fixture.where(:game_id => (params[:game_id]))
            @fixtures = Fixture.all
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @fixtures }
      end
    end
    
     def fix_by_comp
            @fixtures = Fixture.all
            @fixtures_by_comp = @fixtures.group_by { |t| t.game_id }
        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @fixtures }
        end
      end
    
      def fix_by_grid
            @games = Game.all
          respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @fixtures }
          end
        end
    
    # This function imports matches from CSV file and also updates the match id based on what was selected in the view
    def import   
      row_id = Fixture.import(params[:file])
      @g = (params[:game])
      game = @g["game_id"]
      Rails.logger.debug("game in controller: #{game.inspect}")
        Fixture.updaterow(row_id, game)
      redirect_to fixtures_path, notice: "Matches imported."
    end

    # GET /fixtures/1
    # GET /fixtures/1.json
    def show
      @fixture = Fixture.find(params[:id])
 
      respond_to do |format|
        format.html # show.html.erb
        format.xml { render :xml => @expense }
        format.json { render json: @fixture }
      end
    end

    # GET /fixtures/new
    # GET /fixtures/new.json
   

    # GET /fixtures/1/edit
    def edit
      @fixture = Fixture.find(params[:id])
    end

    # POST /fixtures
    # POST /fixtures.json
    def create
      @fixture = @game.fixtures.create(params[:fixture])

      if  @fixture.valid?
          @fixture.save
          redirect_to game_path(@game)
    else
        @fixture.errors
        flash[:error] = @fixture.errors.full_messages
      
      end
    end

    # PUT /fixtures/1
    # PUT /fixtures/1.json
    def update
      @fixture = Fixture.find(params[:id])

      respond_to do |format|
        if @fixture.update_attributes(params[:fixture])
          format.html { redirect_to @fixture, notice: 'Fixture was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @fixture.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /fixtures/1
    # DELETE /fixtures/1.json
    def destroy
      @game = Game.find(params[:game_id])
        @fixture = @game.fixtures.find(params[:id])
        @fixture.destroy
        redirect_to game_path(@game)
  end
  
  def calc
   @fixture = Fixture.find(params[:fixture_id])

    respond_to do |format|

      if @fixture.update_attributes(:fixresultgap => @fixture.matchhomescore-@fixture.matchawayscore)
     
        format.html { redirect_to fixture_path(@fixture) }
        format.json { head :no_content }
      else
        format.html { render action: "show" }
        format.json { render json: @fixture.errors, status: :unprocessable_entity }
      end
    
    end
  end
 
 
  def calc_user 
    @fixture = Fixture.find(params[:fixture_id])
    if @fixture.fixresultgap > 0
      frg = "postive"
    elsif @fixture.fixresultgap == 0
      frg = "draw"
    else 
      frg = "negative"

  end
  
    @pids = params[:predict_ids]
    x = @pids.size-1
    
       
       while x >= 0
         Rails.logger.debug("x in controller loop: #{x.inspect}")
         p = Predict.find(@pids[x])
         eval = p.homescore-p.awayscore
         
          if eval > 0
             ufrg = "postive"
           elsif eval == 0
             ufrg = "draw"
           else 
             ufrg = "negative"
         end
         
             Rails.logger.debug("frg in controller loop: #{frg.inspect}")
         Rails.logger.debug("ufrg in controller loop: #{ufrg.inspect}")
         
          if frg == ufrg
            p.update_attributes(:correct_result => true)
          else
            p.update_attributes(:correct_result => false)
          end 
        x += -1
        end
       
    redirect_to fixture_path(@fixture)
     
  end
 
  
end
