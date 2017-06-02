require_relative './../../spec_helper.rb'

describe BookmarkModule::ListService do
  let!(:company) { create(:company) }
  let(:list_service) { described_class.new({}) }

  describe "#call" do
    context "when no bookmarks are recorded" do
      it "ruturns a not found message" do
        response = list_service.call()
        expect(response).to match("Not found")
      end
    end

    context "when bookmarks exists" do
      let!(:bookmark1) { create(:bookmark, company: company)}
      let!(:bookmark2) { create(:bookmark, company: company)}

      it "return bookmarks" do
        response = list_service.call()

        expect(response).to match(bookmark1.url)
        expect(response).to match(bookmark2.url)
      end
    end

  end
end
