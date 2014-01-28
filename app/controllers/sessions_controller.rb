class SessionsController < ApplicationController
  
  def new
    @users = User.find(:all, :order => 'name')
    end
  
  
  def create
    user = User.find_by_name(params[:user][:name].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
    else
      @users = User.find(:all, :order => 'name')
      flash.now[:error] = 'Invalid name/password combination' # Not quite right!
            render 'new'
    end
  end
  
  def destroy
    sign_out
        redirect_to root_path
    end
   
   
    def old_create_not_in_use
          
      user = User.find_by_name(params[:session][:name].downcase)
      if user && user.authenticate(params[:session][:password])
        sign_in user
        redirect_to user
      else
        flash.now[:error] = 'Invalid name/password combination' # Not quite right!
              render 'new'
      end
    end
   
   
    
end
