# Instance Counter
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # Class Methods
  module ClassMethods
    attr_accessor :count

    def instances
      @@count
    end
  end

  # Instance Methods
  module InstanceMethods
    private

    def register_instance
      self.class.count ||= 0
      self.class.count += 1
    end
  end
end
