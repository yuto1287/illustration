class Public::ListCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    list = List.find(params[:list_id])
    comment = current_user.list_comments.new(list_comment_params)
    comment.list_id = list.id
    comment.save
    redirect_to list_path(list)
  end

  def destroy
    @list_comment = ListComment.find(params[:list_id])
    @list_comment.destroy
    redirect_to request.referer
  end


  private

  def list_comment_params
    params.require(:list_comment).permit(:comment)
  end

end
