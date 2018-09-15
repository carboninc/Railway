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
        send(attr[:type], attr[:attr], attr[:option])
      end
      true
    end

    def valid?
      validate!
    rescue RuntimeError
      false
    end

    private

    def presence(attr, _option)
      value = instance_variable_get("@#{attr}")
      raise "Значение #{attr} не должно быть пустым" if value.empty? || value.nil?
    end

    def format(attr, format)
      value = instance_variable_get("@#{attr}")
      raise 'Укажите номер поезда в формате ...-.. (любые символы и цифры)' unless value =~ format
    end

    def type(attr, type)
      value = instance_variable_get("@#{attr}")
      if value.is_a? Array
        value.each do |station|
          raise 'Требуются экземпляры класса Station' unless station.is_a? type
        end
      else
        raise "Значение #{attr} не является экземпляром класса #{type}" unless value.is_a? type
      end
    end

    def compare_first_end_station(attr, _option)
      value = instance_variable_get("@#{attr}")
      raise 'Станция не может быть одновременно начальной и конечной' if value[0] == value[-1]
    end

    def name_length(attr, _option)
      value = instance_variable_get("@#{attr}")
      raise 'Название должно быть не менее 3 символов' if value.length < 3
    end
  end
end
