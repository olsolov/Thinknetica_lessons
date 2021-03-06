# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, type, *args)
      @validations ||= []

      @validations << { name: name, type: type, args: args }
    end
  end

  module InstanceMethods
    def validate_presence(value)
      raise 'Value should not be nil or empty' if value.nil? || value.empty?
    end

    def validate_format(value, format)
      raise "Value doesn't match regular expression" if value !~ format
    end

    def validate_type(value, klass)
      raise "The attribute value doesn't match the class" unless value.is_a?(klass)
    end

    def validate!
      self.class.validations.each do |validation|
        value = instance_variable_get("@#{validation[:name]}")
        method_name = "validate_#{validation[:type]}"
        args = validation[:args]
        send(method_name, value, *args)
      end
    end

    def valid?
      validate!
    rescue StandardError
      false
    end
  end
end
