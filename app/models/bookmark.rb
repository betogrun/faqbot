require "pg_search"
include PgSearch

class Bookmark < ActiveRecord::Base
  validates_presence_of :url

  has_many :bookmark_hashtags
  has_many :hashtags, through: :bookmark_hashtags
  belongs_to :company

  #include PgSearch
  pg_search_scope :search, :against => [:url]
end
