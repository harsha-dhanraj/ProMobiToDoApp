class DeveloperMailer < ActionMailer::Base
  default from: ENV["GMAIL_USERNAME"]

  def nofify_of_todo_assignment(todo)
  	@todo = todo
  	@developer = @todo.developer  	 
    mail(:to => "#{@developer.name} <#{@developer.email}>", :subject => "New Todo Assigned")
  end

  def nofify_of_todo_unassignment(developer,todo)
  	@developer = developer 
  	@todo = todo  	
    mail(:to => "#{@developer.name} <#{@developer.email}>", :subject => "Todo Unassigned")
  end

end
