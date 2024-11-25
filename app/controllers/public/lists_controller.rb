class Public::ListsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :require_active_user_list, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id
    if @list.save
      redirect_to list_path(@list.id)
    else
      render :new
    end
  end

  def index
    @lists = List.active_lists.order(created_at: :desc).page(params[:page])
  end

  def show
    @list_comment = ListComment.new
  end

  def edit
    unless @list.user.id == current_user.id
      rdirect_to lists_path
    end
  end

  def update
    if @list.update(list_params)
      redirect_to list_path(@list.id)
    else
      render :edit
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path
  end

  private

  def list_params
    params.require(:list).permit(:title, :image, :caption)
  end

  def require_active_user_list
    @list = List.active_lists.find_by_id(params[:id])
    redirect_to lists_path unless @list
  end

  def correct_user
    if @list.user != current_user
      redirect_to root_path
    end
  end
end
