class CrateBookmarkHashtags < ActiveRecord::Migration[5.1]
  def change
    create_table :bookmark_hashtags do |t|
      t.integer :bookmark_id
      t.integer :hashtag_id
    end
  end
end
