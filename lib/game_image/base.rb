module GameImage
  class Base
    include Scalable

    attr_reader :x_position, :y_position, :width, :height, :full_screen
    
    def initialize(settings={}, path:)
      @image_path = path

      @x_position  = settings[:x_position]
      @y_position  = settings[:y_position]
      @width       = settings[:width]
      @height      = settings[:height]
      @full_screen = settings[:full_screen]
    end

    def draw
      image.draw && resize_image
    end

    %w(x_position y_position width height).each do |attribute|
      define_method("adjusted_#{attribute}") { adjust_to_ratio send(attribute) }
    end

    private
    
    def image
      @image ||= Image.new(x: adjusted_x_position, y: adjusted_y_position, path: @image_path)
    end

    def resize_image
      if @settings[:full_screen] == true
        set_image_dimensions($screen.width, $screen.height)
      else
        set_image_dimensions(ajusted_width, ajusted_height)
      end
    end

    def set_image_dimensions(width, height)
      image.width, image.height = width, height
    end

  end
end
