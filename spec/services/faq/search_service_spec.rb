require_relative './../../spec_helper.rb'

describe FaqModule::SearchService do
  before do
    @company = create(:company)
  end

  describe "#call" do

    it "with search commmand: with empty query, return no message" do
      @listService = FaqModule::SearchService.new({'query' => ''})

      response = @listService.call()
      expect(response).to match("Not found")
    end

    it "with search command: With valid query, find question and answer in response" do
        faq = create(:faq, company: @company)

        @listService = FaqModule::SearchService.new({'query' => faq.question.split(" ").sample})

        response = @listService.call()

        expect(response).to match(faq.question)
        expect(response).to match(faq.answer)
      end

  end
end
