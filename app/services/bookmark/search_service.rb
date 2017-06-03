module BookmarkModule
  class SearchService
    def initialize(params)
      @company = Company.last
      @query = params["query"]
    end

    def call

      bookmarks = Bookmark.search(@query)
      response = "*Bookmarks* \n\n"
       bookmarks.each do |bookmark|
         response += "*#{bookmark.id}* - "
         response += "*#{bookmark.url}*\n"
         bookmark.hashtags.each do |h|
           response += "_##{h.name}_ "
         end
         response += "\n\n"
       end
       (bookmarks.count > 0)? response : "Not found"
    end

  end
end
