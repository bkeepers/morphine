require "morphine/version"

module Morphine
  def self.included(base)
    base.extend ClassMethods
  end

  def dependencies
    @dependencies ||= {}
  end

  module ClassMethods
    def register(name, &block)
      define_method name do |*args|
        dependencies[name] ||= instance_exec(*args,&block)
      end

      define_method "#{name}=" do |service|
        dependencies[name] = service
      end
    end
  end
end
