class Developer < User

  has_many :todos  
  
  before_destroy :update_todos


  def update_todos  
  	# Unassign developer from the assigned todos   	
  	self.todos.update_all(:developer_id => nil)
  end

end
