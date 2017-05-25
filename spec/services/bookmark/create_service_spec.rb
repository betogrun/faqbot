require_relative './../../spec_helper.rb'

describe BookmarkModule::CreateService do
  let(:company) { create(:company) }
  let(:url) { "#{FFaker::Internet.http_url}" }
  let(:hashtags) { "#{FFaker::Lorem.word} #{FFaker::Lorem.word}" }
  let(:create_service) { described_class.new(params) }

  describe "#call" do
    context "when no hashtags are provided" do
      let(:params) { {"url" => url} }

      it "receive an error" do
        response = create_service.call()
        expect(response).to match("Hashtag is mandatory")
      end
    end

    context "when the provided url is not valid" do
      let(:params) {{
        "url" => "this is not a valid url",
        "hashtag" => hashtags
        }}

      it "receive an error" do
        response = create_service.call()
        expect(response).to match("Invalid URL")
      end
    end

    context "when valid params are provided" do
      let(:params) { {
        "url" => url,
        "hashtag" => hashtags
        } }

      it "create the bookmark and receive a sucess message" do
        response = create_service.call()
        expect(response).to match("Created successfully")
        expect(Bookmark.last.url).to match(url)
      end

      it "create the hashtags" do
        create_service.call()
        expect(hashtags.split(/[\s,]+/).first).to match(Bookmark.last.hashtags.first.name)
        expect(hashtags.split(/[\s,]+/).last).to match(Bookmark.last.hashtags.last.name)
      end

    end

  end
end
