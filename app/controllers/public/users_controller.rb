class Public::UsersController < ApplicationController
  before_action :active_for_authentication?, only: [:show, :edit, :index, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
    @lists = @user.lists.page(params[:page])
  end

  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end

    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if  @user.update(user_params)
     redirect_to user_path(params[:id])
    else
     render :edit
    end
  end

  def destroy
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def followings
    @user = User.find(params[:id])
		@users = @user.followings.active_users
  end

  def followers
    @user = User.find(params[:id])
		@users = @user.followers.active_users
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image,)
  end

  def active_for_authentication?
    @user = User.find_by_id(params[:id])
    if (!current_user || current_user.is_deleted) || (@user.is_deleted)
      redirect_to root_path
    end
  end

  def correct_user
    if @user != current_user
      redirect_to lists_path
    end
  end
end
