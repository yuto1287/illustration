class Admin::ListCommentsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    @list_comments = ListComment.all
    @user = User.all
  end

  def destroy
    @list_comment = ListComment.find(params[:id])
    @list_comment.destroy
    redirect_to admin_list_comments_path, notice: 'コメントを削除しました。'
  end
end
