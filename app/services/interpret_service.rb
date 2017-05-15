class InterpretService
  def self.call action, params
    if service = class_name(action).safe_constantize
      service.new(params).call()
    else
      "Not found"
    end
  end

  private

  def self.class_name(action)
    class_name = "#{action.camelize}Service"
    "FaqModule::" + class_name if FaqModule.constants.include?(class_name.to_sym)
  end
end
