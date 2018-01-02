module Representable

  def self.included(base)
    base.extend(Macros)

    def represented_resource
      self.class.represented_resource
    end
  end

  module Macros
    attr_accessor :represented_resource

    def representing_resource(resource_name)
      @represented_resource = resource_name
    end
  end

end
