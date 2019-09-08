class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    booklist = Booklist.find(params[:booklist_id])
    current_user.like(booklist)
    flash[:success] = 'お気に入り登録をしました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    booklist = Booklist.find(params[:booklist_id])
    current_user.unlike(booklist)
    flash[:success] = 'お気に入り登録を解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
