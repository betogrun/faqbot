class Bookmark < ActiveRecord::Base
  validates_presence_of :url

  has_many :bookmark_hashtags
  has_many :hashtags, through: :bookmark_hashtags
  belongs_to :company
end
