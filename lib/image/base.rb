module Image
  class Base

    ALLOWED_SETTINGS_KEYS = [ :x_position, :y_position, :width, :height ].freeze
    
    def initialize(settings, path:, options={})
      @settings = settings
      @image_path = path
    end

    def draw
      image.draw && resize_image
    end

    available_settings_keys.each do |key|
      define_method(key)               { @settings[key]             }
      define_method("adjusted_#{key}") { adjust_to_ratio send(key) }
    end

    private

    def available_settings_keys
      ALLOWED_SETTINGS_KEYS - @settings.keys
    end

    def image
      @image ||= Image.new(x: adjusted_x_position, y: adjusted_y_position, path: @image_path)
    end

    def resize_image
      @image.width = ajusted_width
      @image.height = ajusted_height
    end
  
    def adjust_to_ratio(size)
      (size * $screen.ratio).to_i
    end

  end
end
