class PredictsController < ApplicationController
  # GET /predicts
  # GET /predicts.json
  def index
    @predicts = Predict.all
       @fixture = Fixture.find(params[:fixture_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @predicts }
    end
  end

  # GET /predicts/1
  # GET /predicts/1.json
  def show
    
    @predict = Predict.find(params[:id])
    @fixture = Fixture.find(params[:fixture_id])

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

  # POST /predicts
  # POST /predicts.json
  def create
      @games = Game.all
      @fixtures = Fixture.all
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

    respond_to do |format|
      if @predict.update_attributes(params[:predict])
        format.html { redirect_to @predict, notice: 'Predict was successfully updated.' }
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
     @user = User.find(params[:user_id])
        @predict = @user.predicts.find(params[:id])
        @predict.destroy
        redirect_to user_path(@user)
  end
end
