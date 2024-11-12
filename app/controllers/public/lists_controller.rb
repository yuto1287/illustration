class Public::ListsController < ApplicationController
  #before_action :authenticate_user!

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
    @lists = List.all.order(created_at: :desc).page(params[:page])
  end

  def show
    @list = List.find(params[:id])
    @list_comment = ListComment.new
  end

  def edit
    @list = List.find(params[:id])
    unless @list.user.id == current_user.id
      rdirect_to lists_path
    end
  end

  def update
    @list = List.find(params[:id])
    if @list.update(list_params)
      redirect_to list_path(@list.id)
    else
      render :edit
    end
  end

  def destroy
    list = List.find(params[:id])
    list.destroy
    redirect_to lists_path
  end

  private

  def list_params
    params.require(:list).permit(:title, :image, :caption)
  end
end
