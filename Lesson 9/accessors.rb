# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*attributes)
    attributes.each do |attribute|
      attribute_var = "@#{attribute}".to_sym
      history_var = "@#{attribute}_history".to_sym

      define_method(attribute) { instance_variable_get(attribute_var) }
      define_method("#{attribute}_history".to_sym) { instance_variable_get(history_var) }

      define_method("#{attribute}=".to_sym) do |value|
        if instance_variable_get(history_var).nil?
          instance_variable_set(history_var, [])
        else
          old_value = instance_variable_get(attribute_var)
          history = instance_variable_get(history_var)
          history << old_value
        end
        instance_variable_set(attribute_var, value)
      end
    end
  end

  def strong_attr_accessor(attribute, klass)
    attribute_var = "@#{attribute}".to_sym
    define_method(attribute) { instance_variable_get(attribute_var) }
    define_method("#{attribute}=".to_sym) do |value|
      raise "Types don't match" unless value.is_a?(klass)

      instance_variable_set(attribute_var, value)
    end
  end
end
