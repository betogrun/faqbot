class CrateBookmarks < ActiveRecord::Migration[5.1]
  def change
    create_table :bookmarks do |t|
      t.string :url
      t.integer :company_id
    end
  end
end
