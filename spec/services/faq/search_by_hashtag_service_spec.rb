require_relative './../../spec_helper.rb'

describe FaqModule::SearchByHashtagService do
  before do
    @company = create(:company)
  end

  describe "#call" do

    it "with search_by_hashtag command: With invalid hashtag, return don't find message" do
      @listService = FaqModule::SearchByHashtagService.new({'query' => ''})

      response = @listService.call()
      expect(response).to match("Not found")
    end

    it "with search_by_hashtag command: With valid hashtag, find question and answer in response" do
      faq = create(:faq, company: @company)
      hashtag = create(:hashtag, company: @company)
      create(:faq_hashtag, faq: faq, hashtag: hashtag)

      @listService = FaqModule::SearchByHashtagService.new({'query' => hashtag.name})

      response = @listService.call()

      expect(response).to match(faq.question)
      expect(response).to match(faq.answer)
    end

  end
end
