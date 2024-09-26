class UserController < ApplicationController
  def show
    @user = User.find(params[:id])
    @lists = @user.lists
  end

  def edit
  end
  private

  def user_params
    params.require(:user).permit(:name, :prfile_image)
  end
end
