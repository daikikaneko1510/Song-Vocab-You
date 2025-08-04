class TweetsController < ApplicationController
    after_action :karihozon, only: [:index]
    before_action :authenticate_user!, only: [:new, :create]
    
    def index
      @tweets= Tweet.all
      @tags = Tag.all
      @tweets = @tweets.where("lyrics LIKE ? ",'%' + params[:search] + '%') if params[:search].present?
      if params[:tag_ids].present?
        tweets_ids = []
        params[:tag_ids].each do |key, value| 
        if value == "1"
          Tag.find_by(name: key).tweets.each do |p| 
          tweets_ids << p.id
        end
      end
    end
    tweets_ids = tweets_ids.uniq
    #キーワードとタグのAND検索
    @tweets = @tweets.where(id: tweets_ids) if tweets_ids.present?
  end
      if params[:tag]
      Tag.create(name: params[:tag])
      end
    end

    def search
    @tag_list = Tag.all               
    @tag = Tag.find(params[:tag_id])
    @itirans = @tag.tweets.all       
    end

    def new
    @tweet = Tweet.new
    end

  def create
    tweet = Tweet.new(tweet_params)
    tweet.user_id = current_user.id
    if tweet.save!
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
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
      redirect_to :action => "show", :id => tweet.id
    else
      redirect_to :action => "new"
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to action: :index
  end

  def karihozon
    if user_signed_in?
      user = current_user
      if user.karihozon == nil
        user.update!(karihozon:params[:search])
      end
      user.update!(karihozon:params[:search])
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:song_name, :musician, :lyrics, :youtube_url, tag_ids:[])
  end
end
