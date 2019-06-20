# frozen_string_literal: true

module Validation
  def validate(name, type, *args)
    @validations ||= []

    @validations << { name: name, type: type, args: args }
  end

  def validate!
    # Содержит инстанс-метод validate!, который запускает все проверки (валидации),
    # указанные в классе через метод класса validate.
    # В случае ошибки валидации выбрасывает исключение с сообщением о том,
    # какая именно валидация не прошла

    @validations.each do |validation|
      var_name = validation[:name]
      var_value = instance_variable_get(var_name)
      type = validation[:type]
      args = validation[:args]
      case type
      when :presence
        raise 'Value should not be nil or empty' if var_value.nil? || var_value.empty?
      when :format
        raise "Value doesn't match regular expression" if var_value !~ args
      when :type
        raise "The attribute value doesn't match the class" if var_value.is_a?(args)
      end      
    end
  end

  def valid?
    validate!
  rescue StandardError
    false
  end
end
