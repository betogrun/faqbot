require_relative './../../spec_helper.rb'

describe FaqModule::ListService do
  before do
    @company = create(:company)
  end

  describe "#call" do
    it "with list command: with zero faqs, return don't find message" do
      @listService = FaqModule::ListService.new({})

      response = @listService.call()
      expect(response).to match("Not found")
    end

    it "with faqs, find questions and answer in response" do
      @listService = FaqModule::ListService.new({})

      faq1 = create(:faq, company: @company)
      faq2 = create(:faq, company: @company)

      response = @listService.call()

      expect(response).to match(faq1.question)
      expect(response).to match(faq1.answer)

      expect(response).to match(faq2.question)
      expect(response).to match(faq2.answer)
    end

  end
end
