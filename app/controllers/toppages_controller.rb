class ToppagesController < ApplicationController
  def index
    if logged_in?
      @booklist = current_user.booklists.build  # form_with 用
      @booklists = current_user.booklists.order(id: :desc).page(params[:page]).per(5)
    end
  end
end
