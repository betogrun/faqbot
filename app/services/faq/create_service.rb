module FaqModule
  class CreateService
    def initialize(params)
      @company = Company.last
      @question = params["question.original"]
      @anwser = params["answer.original"]
      @hashtags = params['hashtags.original']
    end

    def call
      return "Hashtag is mandatory" if @hashtags == nil || @hashtags == ""
      begin
        Faq.transaction do
          @faq = Faq.create(question: @question, answer: @answer, company: @company)
          @hashtags.split(/[\s,]+/).each do |hashtag|
            @faq.hashtags << Hashtag.create(name: hashtag)
          end
        end
        "Created successfully: #{@faq.question}"
      rescue
        "Errors during Faq creation: #{@faq}"
      end

    end
  end
end
