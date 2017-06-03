require_relative './../../spec_helper.rb'

describe BookmarkModule::RemoveService do
  let(:company) { create(:company)}
  let(:remove_service) { described_class.new(params) }

  describe "#call" do
    context "when the given id is valid" do
      let(:bookmark) { create(:bookmark, company: company)}
      let(:params) { {"id" => bookmark.id} }
      it "remove the bookmark" do
        response = remove_service.call()

        expect(response).to match("Deleted successfully")
      end
    end

    context "when the given id is invalid" do
      let(:params) { {"id" => rand(1..9999)} }
      it "return an error message" do
        response = remove_service.call()

        expect(response).to match("Invalid bookmark, check Id")
      end
    end
  end

end
