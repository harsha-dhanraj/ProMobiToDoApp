class AnalyticsController < ApplicationController
  include AnalyticsHelper
  
  before_action :authenticate_user!
	
  authorize_resource :class => false
  
  def index  	
    generate_graph_data    
  end
end
