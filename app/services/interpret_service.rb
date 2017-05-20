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
    class_name = "FaqModule::" + class_name if FaqModule.constants.include?(class_name.to_sym)
    class_name
  end
end
