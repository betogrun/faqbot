class BookmarkHashtag < ActiveRecord::Base
  validates_presence_of :bookmark_id, :hashtag_id

  belongs_to :bookmark
  belongs_to :hashtag
end
