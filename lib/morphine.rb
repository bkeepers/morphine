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
      define_method name do
        dependencies[name] ||= instance_eval(&block)
      end
    end
  end
end
