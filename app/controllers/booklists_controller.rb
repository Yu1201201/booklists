class BooklistsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    @booklists = Booklist.all
  end

  def show
    @booklist = Booklist.find(params[:id])
  end

  def new
    @booklist = Booklist.new
  end

  def create
    @booklist = current_user.booklists.build(booklist_params)
    if @booklist.save
      flash[:success] = 'Booklistを投稿しました。'
      redirect_to root_url
    else
      @booklists = current_user.booklists.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'Booklistの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def edit
    @booklist = Booklist.find(params[:id])
  end

  def update
    @booklist = Booklist.find(params[:id])

    if @booklist.update(booklist_params)
      flash[:success] = 'Booklist は正常に更新されました'
      redirect_to @booklist
    else
      flash.now[:danger] = 'Booklist は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @booklist.destroy
    flash[:success] = 'Booklistを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def booklist_params
    params.require(:booklist).permit(:title, :review, :image)
  end
  
  def correct_user
    @booklist = current_user.booklists.find_by(id: params[:id])
    unless @booklist
      redirect_to root_url
    end
  end
end
