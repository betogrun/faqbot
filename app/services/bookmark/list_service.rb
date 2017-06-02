module BookmarkModule
  class ListService
    def initialize(params)
      @company = Company.last
    end

    def call
      bookmarks = @company.bookmarks
      response = "*Bookmarks* \n\n"
      bookmarks.each do |bookmark|
        response += "*#{bookmark.id}* - "
        response += ">#{bookmark.url}\n"
        bookmark.hashtags.each do |h|
          response += "_##{h.name}_ "
        end
        response += "\n\n"
      end
      (bookmarks.count > 0)? response : "Not found"
    end

  end
end
