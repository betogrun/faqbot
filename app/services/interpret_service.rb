class InterpretService
  def self.call action, params, intent
    if service = class_name(action, intent).safe_constantize
      service.new(params).call()
    else
      "Not found"
    end
  end

  private

  def self.class_name(action, intent)
    module_name = intent.split(/[\s_]+/).last.camelize + "Module::"
    class_name = "#{action.camelize}Service"
    class_name = module_name + class_name if self.valid? module_name, class_name
    class_name
  end

  def self.valid? module_name, class_name
    module_const = module_name.safe_constantize
    module_const.constants.include?(class_name.to_sym) if module_const
  end
end
