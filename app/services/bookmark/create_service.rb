module BookmarkModule
  class CreateService
    def initialize(params)
      @company = Company.last
      @url = params["url"]
      @hashtags = params["hashtag"]
    end

    def call
      return "Hashtag is mandatory" if @hashtags == nil || @hashtags == ""
      return "Invalid URL" unless @url =~ /\A#{URI::regexp}\z/
      begin
        Bookmark.transaction do
          bookmark = Bookmark.create!(url: @url, company: @company)
          @hashtags.split(/[\s,]+/).each do |hashtag|
            bookmark.hashtags << Hashtag.create(name: hashtag)
          end
        end
        "Created successfully"
      rescue => e
        "Errors during Bookmark creation: #{e}"
      end
    end
    
  end
end
