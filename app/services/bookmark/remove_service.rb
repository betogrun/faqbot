module BookmarkModule
  class RemoveService
    def initialize(params)
      @company = Company.last
      @params = params
      @id = params["id"]
    end

    def call
      begin
        bookmark = @company.bookmarks.find @id
      rescue
        return "Invalid bookmark, check Id"
      end

      Bookmark.transaction do
        bookmark.hashtags.each do |h|
          if h.faqs.count <= 1
            h.delete
          end
        end
        bookmark.delete
        "Deleted successfully"
      end
    end
  end
end
