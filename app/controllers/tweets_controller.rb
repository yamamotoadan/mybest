class TweetsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    # 投稿が存在するかどうかを確認
    if Tweet.exists?
      if params[:id]
        @tweet = Tweet.find_by(id: params[:id])
        # 指定されたIDの投稿が存在しない場合、最初の投稿を表示
        @tweet ||= Tweet.first
      else
        @tweet = Tweet.first
      end
    else
      @tweet = nil
    end
    @comments = @tweet.comments
    @comment = Comment.new
  end

  def new
    @tweet = Tweet.new
  end

  def create
    tweet = Tweet.new(tweet_params)
    tweet.user_id = current_user.id
    if tweet.save!
      redirect_to action: "index"
    else
      redirect_to action: "new"
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
  end
  

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.update(tweet_params)
      redirect_to action: "show", id: tweet.id
    else
      redirect_to action: "new"
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to action: :index
  end

  # 次の投稿を取得
  def next
    @tweet = Tweet.where("id > ?", params[:id]).first || Tweet.first
    redirect_to tweets_path(id: @tweet.id)
  end

  # 前の投稿を取得
  def prev
    @tweet = Tweet.where("id < ?", params[:id]).last || Tweet.last
    redirect_to tweets_path(id: @tweet.id)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:title, :body, :image, :video)
  end
end
