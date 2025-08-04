class CreateTweets < ActiveRecord::Migration[8.0]
  def change
    create_table :tweets do |t|
      t.string :song_name
      t.string :musician
      t.text :lyrics

      t.timestamps
    end
  end
end
