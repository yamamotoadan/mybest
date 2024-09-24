class UsersController < ApplicationController
  def show
      @user = User.find(params[:id]) 
  end
  def iine
    @user = User.find(params[:id]) 
    @tweets = Tweet.all
  end
  def mypage
    @user = current_user
  end
end
