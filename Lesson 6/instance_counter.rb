module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    @@instances = 0 
    
    attr_reader :instances

    def self.instances
      @@instances
    end
  end

  module InstanceMethods
    def initialize
      self.register_instance
    end

    def register_instance
      @@instances +=1
    end
  end
end
