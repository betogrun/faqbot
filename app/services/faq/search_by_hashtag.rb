module FaqModule
  class SearchByHashtagService
    def initialize(params)
      @company = Company.last
      @query = params["query"]
    end

    def call
      faqs = []
      @company.faqs.each do |faq|
        faq.hashtags.each do |hashtag|
          faqs << faq if hashtag.name == @query
        end
      end

      response = "*Perguntas e Respostas* \n\n"
       faqs.each do |f|
         response += "*#{f.id}* - "
         response += "*#{f.question}*\n"
         response += ">#{f.answer}\n"
         f.hashtags.each do |h|
           response += "_##{h.name}_ "
         end
         response += "\n\n"
       end
       (faqs.count > 0)? response : "Not found"
    end

  end
end
