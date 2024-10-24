class Admin::DashboardsController < ApplicationController
  layout 'admin'
  befor_action :authenticate_admin!
  
  def index
    @users = User.all
  end 
  
end
