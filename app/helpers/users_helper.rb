module UsersHelper
  
  def get_name(user_id)
    
    return User.where(:id => user_id).first.name
  end
end
