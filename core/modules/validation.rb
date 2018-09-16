# Validation
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # Class Method Validate: get params and types for validation
  module ClassMethods
    attr_accessor :validation

    def validate(name, type, option = nil)
      @validation ||= []
      @validation << { attr: name, type: type, option: option }
    end
  end

  # Instance Method Validate: validation of attributes depending on the selected method
  module InstanceMethods
    def validate!
      self.class.validation.each do |attr|
        method = "validate_#{attr[:type]}".to_sym
        send(method, attr[:attr], attr[:option])
      end
      true
    end

    def valid?
      validate!
    rescue RuntimeError
      false
    end

    private

    def validate_presence(attr, _option)
      value = instance_variable_get("@#{attr}")
      raise "Значение #{attr} не должно быть пустым" if value.empty? || value.nil?
    end

    def validate_format(attr, format)
      value = instance_variable_get("@#{attr}")
      raise 'Неверно указан формат' unless value =~ format
    end

    def validate_type(attr, type)
      value = instance_variable_get("@#{attr}")
      if value.is_a? Array
        value.each do |element|
          raise "#{element} не является экземпляром класса #{type}" unless element.is_a? type
        end
      else
        raise "Значение #{attr} не является экземпляром класса #{type}" unless value.is_a? type
      end
    end

    def validate_name_length(attr, _option)
      value = instance_variable_get("@#{attr}")
      raise 'Название должно быть не менее 3 символов' if value.length < 3
    end
  end
end
