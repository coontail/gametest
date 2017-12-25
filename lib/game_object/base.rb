module GameObject
  class Base

    attr_reader :key

    def initialize(key)
      @key = key
    end

    def data
      @data ||= GetDataService.new(self, data_options).call
    end

    def image
      @image ||= GetImageService.new(self, image_options).call
    end

    def hitbox
      @hitbox ||= GetHitboxService.new(self, hitbox_options).call
    end

    def text
      @text ||= GetTextService.new(self, text_options).call
    end

    # def description
    #   @description ||= GetDescriptionService.new(self, description_options).call
    # end

    %w(data image hitbox text).each do |method_name|
      define_method("#{method_name}_options") { {} }
    end

  end
end
