module FaqModule
  class SearchService
    def initialize(params)
      @company = Company.last
      @query = params["query"]
    end

    def call
      faqs = Faq.search(@query).where(company: @company)
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
