require_relative './../../spec_helper.rb'

describe BookmarkModule::SearchService do
  let(:company) { create(:company) }
  let(:search_service) { described_class.new(params) }

  describe "#call" do
    context "when query is empty" do
      let(:params) { {'query' => ''}}
      it "return no message" do
        response = search_service.call()

        expect(response).to match("Not found")
      end
    end

    context "when query is valid" do
      let(:bookmark) { create(:bookmark, company: company) }
      let(:params) { {'query' => bookmark.url.sub(/^https?\:\/\/(www.)?/,'') } }

      it "find a bookmark" do
        response = search_service.call()

        expect(response).to match(bookmark.url)
      end
    end
  end
end
