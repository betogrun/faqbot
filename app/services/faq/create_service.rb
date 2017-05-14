module FaqModule
  class CreateService
    def initialize(params)
      @company = Company.last
      @question = params["question.original"]
      @answer = params["answer.original"]
      @hashtags = params['hashtags.original']
    end

    def call
      return "Hashtag is mandatory" if @hashtags == nil || @hashtags == ""
      begin
        Faq.transaction do
          faq = Faq.create!(question: @question, answer: @answer, company: @company)
          @hashtags.split(/[\s,]+/).each do |hashtag|
            faq.hashtags << Hashtag.create(name: hashtag)
          end
        end
        "Created successfully"
      rescue => e
        "Errors during Faq creation: #{e}"
      end
    end
  end
end
