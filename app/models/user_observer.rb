class UserObserver < ActiveRecord::Observer
  def after_update(user)                
    user.send_confirmation_instructions if user.email_was != user.email        
  end
end