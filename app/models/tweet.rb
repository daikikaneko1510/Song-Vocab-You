class Tweet < ApplicationRecord
belongs_to :user
has_many :tweet_tag_relations, dependent: :destroy
has_many :tags, through: :tweet_tag_relations, dependent: :destroy

has_many :likes, dependent: :destroy
has_many :liked_users, through: :likes, source: :user

    def self.for_search(term)
        if term.present?
            # Implement searching however you'd like
            where("lyrics ILIKE ?", "%#{term}%")
            else
            all
        end
    end
end