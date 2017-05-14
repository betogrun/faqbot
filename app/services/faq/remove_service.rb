module FaqModule
  class RemoveService
    def initialize(params)
      @company = Company.last
      @params = params
      @id = params["id"]
    end

    def call
      begin
        faq = @company.faqs.find @id
      rescue
        return "invalid question, check Id"
      end
       
      Faq.transaction do
        faq.hashtags.each do |h|
          if h.faqs.count <= 1
            h.delete
          end
        end
        faq.delete
        "Deleted successfully"
      end
    end
  end
end
