module GameObject
  class Base

    attr_reader :key

    def initialize(key)
      @key = key
    end

    def data
      @data ||= GetDataService.call(self, options: data_options)
    end

    def image
      @image ||= GetImageService.call(self, options: image_options)
    end

    def hitbox
      @hitbox ||= GetHitboxService.call(self, options: hitbox_options)
    end

    def text
      @text ||= GetTextService.call(self, options: text_options)
    end

    %w(data image hitbox text).each do |method_name|
      define_method("#{method_name}_options"){ {} }
    end

  end
end
