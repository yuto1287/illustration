class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    if params[:model] == 'user'
      @users = User.search_for(params[:content], params[:method]).order(created_at: :desc)
      render 'users/index'
    else
      @lists = List.search_for(params[:content], params[:method]).order(created_at: :desc)
      render 'lists/index'
    end
  end 
end
