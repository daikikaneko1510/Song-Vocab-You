class AddYoutubeUrlToTweets < ActiveRecord::Migration[8.0]
  def change
    add_column :tweets, :youtube_url, :string
  end
end
