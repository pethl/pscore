class FixturesController < ApplicationController

    # GET /fixtures
    # GET /fixtures.json
    def index
      @fixtures = Fixture.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @fixtures }
      end
    end

    # GET /fixtures/1
    # GET /fixtures/1.json
    def show
      @fixture = Fixture.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
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
      @game = Game.find(params[:game_id])
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
end
