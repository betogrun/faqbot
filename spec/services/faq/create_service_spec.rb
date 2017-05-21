require_relative './../../spec_helper.rb'

describe FaqModule::CreateService do
  before do
    @company = create(:company)

    @question = FFaker::Lorem.sentence
    @answer = FFaker::Lorem.sentence
    @hashtags = "#{FFaker::Lorem.word} #{FFaker::Lorem.word}"
  end

  describe "#call" do
    it "without hashtag params, will receive a error" do
      @createService = FaqModule::CreateService.new({
        "question" => @question,
        "answer" => @anser
        })
      response = @createService.call()
      expect(response).to match("Hashtag is mandatory")
    end

    it "with valid params, receive sucesse message" do
      @createService = FaqModule::CreateService.new({
        "question" => @question,
        "answer" => @answer,
        "hashtag" => @hashtags
        })
      response = @createService.call()
      expect(response).to match("Created successfully")
    end

    it "With valid params, find question and anwser in database" do
      @createService = FaqModule::CreateService.new({
        "question" => @question,
        "answer" => @answer,
        "hashtag" => @hashtags})

      @createService.call()
      expect(Faq.last.question).to match(@question)
      expect(Faq.last.answer).to match(@answer)
    end

    it "With valid params, hashtags are created" do
      @createService = FaqModule::CreateService.new({
        "question" => @question,
        "answer" => @answer,
        "hashtag" => @hashtags})

      @createService.call()
      expect(@hashtags.split(/[\s,]+/).first).to match(Hashtag.first.name)
      expect(@hashtags.split(/[\s,]+/).last).to match(Hashtag.last.name)
    end


  end
end
