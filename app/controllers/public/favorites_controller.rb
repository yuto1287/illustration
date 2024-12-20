class Public::FavoritesController < ApplicationController
  #before_action :authenticate_admin!

  def create
    list = List.find(params[:list_id])
    favorite = current_user.favorites.new(list_id: list.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    list = List.find(params[:list_id])
    favorite = current_user.favorites.find_by(list_id: list.id).page(params[:page])
    favorite.destroy
    redirect_to request.referer
  end
end
