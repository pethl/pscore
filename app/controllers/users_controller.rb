class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:edit, :update, :destroy, ]
  before_filter :admin_user,     only: [:edit, :update, :destroy]
  
  def fetch_user
      @user = User.find_by_id(params[:id])
    end
  
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @current_game = Game.where(:current => true)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def import
     User.import(params[:file])
     redirect_to users_path, notice: "Users imported."
   end


   def get_records
     @user = (params[:user_id])
     i = 0
     x = Fixture.where(:game_id => (params[:game_id])).count
     @fixtureids = Fixture.where(:game_id => (params[:game_id])).collect {|r| r.id}

     while i < x do
         s = Predict.new(:game_id => (params[:game_id]), :fixture_id => @fixtureids[i], :user_id => @user)
         s.save
         i = i += 1
     end
        redirect_to :back
        
    end
      
  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @current_game = Game.where(:current => true)
    @last_game = Game.where(:lastyear => true)
    @fixtures = Fixture.where(:game_id => @current_game[0].id)
    @previous_fixtures = Fixture.where(:game_id => @last_game[0].id)
    @predicts = Predict.where(:game_id => @current_game[0].id, :user_id => (params[:id]))
    @predicts = @predicts.sort_by { |h| h[:id] }
    @previous_predicts = Predict.where(:game_id => @last_game[0].id, :user_id => (params[:id])).select([:id, :fixture_id, :awayscore, :homescore, :points])

    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    

    respond_to do |format|
      if @user.save
        sign_in @user
      
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        sign_in @user
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
  private
    
  def correct_user
        @user = User.find(params[:id])
        redirect_to(root_path) unless current_user?(@user)
  end
  
  def admin_user
        redirect_to(root_path) unless current_user.admin?
  end
     
end
