class User < ApplicationRecord
 
devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable
has_many :tweets, dependent: :destroy
has_many :likes, dependent: :destroy
has_many :liked_tweets, through: :likes, source: :tweet
 def already_liked?(tweet)
    self.likes.exists?(tweet_id: tweet.id)
  end
validates :name, presence: true
validates :profile, length: { maximum: 200 } 
end
