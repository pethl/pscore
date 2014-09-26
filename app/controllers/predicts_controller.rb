class PredictsController < ApplicationController
  # GET /predicts
  # GET /predicts.json
  def index
      @current = Game.where(:current => true)
     @predicts = Predict.where(:game_id => @current[0].id)
     @predicts = @predicts.sort_by { |h| h[:id] }
    @predicts_by_fixture = @predicts.group_by { |t| t.fixture_id }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @predicts }
    end
  end


  def pastpredict
    @users = User.all
    @users = @users.sort_by { |h| h[:id] }
    @last_game = Game.where(:lastyear => true)
    @predicts = Predict.where(:game_id => @last_game[0].id)
    @predicts_by_fixture = @predicts.group_by { |t| t.fixture_id }
   # not sure why this is here...    @fixture = Fixture.find(params[:fixture_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @predicts }
    end
  end

  # GET /predicts/1
  # GET /predicts/1.json
  def show
    
    @predict = Predict.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @predict }
    end
  end

  # GET /predicts/new
  # GET /predicts/new.json
  def new
    @predict = Predict.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @predict }
    end
  end

  # GET /predicts/1/edit
  def edit
    @predict = Predict.find(params[:id])
  end
  

  def import   
      row_id = Predict.import(params[:file])
      Rails.logger.debug("row_id in P_controller: #{row_id.inspect}")
      @g = (params[:game])
      Rails.logger.debug("g in P_controller: #{@g.inspect}")
      game = @g["game_id"]
      Rails.logger.debug("game in P_controller: #{game.inspect}")
        Predict.updaterow(row_id, game)
      redirect_to predicts_pastpredict_path, notice: "Predictions imported."
    end

  # POST /predicts
  # POST /predicts.json
  def create
      @predicts = Predict.all

     @user = User.find(params[:user_id])
      @predict = @user.predicts.create(params[:predict])

      if  @predict.valid?
          @predict.save
          redirect_to user_path(@user)
    else
        @predict.errors
        flash[:error] = @predict.errors.full_messages
      
      end
  end

  # PUT /predicts/1
  # PUT /predicts/1.json
  def update
    @predict = Predict.find(params[:id])
   #  @fixture = Fixture.find(params[:fixture_id]) 

    respond_to do |format|
      if @predict.update_attributes(params[:predict])
        format.html { redirect_to @predict, notice: 'Prediction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @predict.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /predicts/1
  # DELETE /predicts/1.json
  def destroy
      #  this was previous version, amended as failing in Predicts /index delete
  #      @user = User.find(params[:user_id])
    #       @predict = @user.predicts.find(params[:id])
      #     @predict.destroy
        #   redirect_to user_path(@user)
        @predict = Predict.find(params[:id])
        @predict.destroy
          redirect_to predicts_path
  end
  
  
  
end
