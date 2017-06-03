require_relative './../spec_helper.rb'

describe InterpretService do
  before :each do
    @company = create(:company)
  end

  describe "#help" do
    it "calls help service" do
      response = InterpretService.call('help', {}, 'help')
      expect(response).to match('help')
    end
  end

  describe '#list' do
    it "With zero faqs, return don't find message" do
      response = InterpretService.call('list', {}, 'list_faq')
      expect(response).to match("Not found")
    end

    it "With two faqs, find questions and answer in response" do
      faq1 = create(:faq, company: @company)
      faq2 = create(:faq, company: @company)

      response = InterpretService.call('list', {}, 'list faq')

      expect(response).to match(faq1.question)
      expect(response).to match(faq1.answer)

      expect(response).to match(faq2.question)
      expect(response).to match(faq2.answer)
    end
  end

  describe '#search' do
    it "With empty query, return don't find message" do
      response = InterpretService.call('search', {"query": ''}, 'search faq')
      expect(response).to match("Not found")
    end

    it "With valid query, find question and answer in response" do
      faq = create(:faq, company: @company)

      response = InterpretService.call('search', {"query" => faq.question.split(" ").sample}, 'search faq')

      expect(response).to match(faq.question)
      expect(response).to match(faq.answer)
    end
  end

  describe '#search by category' do
    it "With invalid hashtag, return don't find message" do
      response = InterpretService.call('search_by_hashtag', {"query": ''}, 'search_by_hashtag faq')
      expect(response).to match("Not found")
    end

    it "With valid hashtag, find question and answer in response" do
      faq = create(:faq, company: @company)
      hashtag = create(:hashtag, company: @company)
      create(:faq_hashtag, faq: faq, hashtag: hashtag)

      response = InterpretService.call('search_by_hashtag', {"query" => hashtag.name}, 'search_by_hashtag faq')

      expect(response).to match(faq.question)
      expect(response).to match(faq.answer)
    end
  end

  describe '#create' do
    before do
      @question = FFaker::Lorem.sentence
      @answer = FFaker::Lorem.sentence
      @hashtags = "#{FFaker::Lorem.word}, #{FFaker::Lorem.word}"
    end

    it "Without hashtag params, receive a error" do
      response = InterpretService.call('create', {"question" => @question, "answer" => @answer}, 'create faq')
      expect(response).to match("Hashtag is mandatory")
    end

    it "With valid params, receive success message" do
      response = InterpretService.call('create', {"question" => @question, "answer" => @answer, "hashtag" => @hashtags}, 'create_faq')
      expect(response).to match("Created successfully")
    end

    it "With valid params, find question and anwser in database" do
      InterpretService.call('create', {"question" => @question, "answer" => @answer, "hashtag" => @hashtags}, 'create_faq')
      expect(Faq.last.question).to match(@question)
      expect(Faq.last.answer).to match(@answer)
    end

    it "With valid params, hashtags are created" do
      InterpretService.call('create', {"question" => @question, "answer" => @answer, "hashtag" => @hashtags}, 'create_faq')
      expect(@hashtags.split(/[\s,]+/).first).to match(Hashtag.first.name)
      expect(@hashtags.split(/[\s,]+/).last).to match(Hashtag.last.name)
    end
  end

  describe '#remove' do
    it "With valid ID, remove Faq" do
      faq = create(:faq, company: @company)
      response = InterpretService.call('remove', {"id" => faq.id}, 'remove_from_faq')
        expect(response).to match("Deleted successfully")
    end

    it "With invalid ID, receive error message" do
      response = InterpretService.call('remove', {"id" => rand(1..9999)}, 'remove_from_faq')
      expect(response).to match("invalid question, check Id")
    end
  end

  describe "#class_name" do
    it "returns the services' class name" do
      values = [
        {action: "create", intent: "create_faq", expected: "FaqModule::CreateService" },
        {action: "list", intent: "list_faq", expected: "FaqModule::ListService" },
        {action: "create", intent: "create bookmark", expected: "BookmarkModule::CreateService" },
        {action: "help", intent: "help", expected: "HelpService"}
      ]

      values.each do |value|
        class_name = described_class.class_name(value[:action], value[:intent])
        expect(class_name).to be_eql(value[:expected])
      end


    end
  end

end
