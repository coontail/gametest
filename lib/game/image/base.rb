module Game::Image
  class Base
    include Scalable

    attr_reader :x_position, :y_position, :width, :height, :full_screen, :path

    def initialize(settings={})
      @path        = settings[:image_path]
      @x_position  = settings[:x_position]
      @y_position  = settings[:y_position]
      @width       = settings[:width]
      @height      = settings[:height]
      @full_screen = settings[:full_screen]
    end

    def draw
      (image && resize_image) if valid?
    end

    %w(width height).each do |attribute|
      define_method("adjusted_#{attribute}") { adjust_to_ratio send(attribute) }
    end

    %w(x_position y_position).each do |attribute|
      define_method("adjusted_#{attribute}") do
        full_screen ? 0 : adjust_to_ratio(send(attribute))
      end
    end

    private

    # TODO réfléchir à mes conditions de validité, où les foutre et tout ça
    def valid?
      !@path.nil?
    end

    def image
      # ||= impossible since Image.new DRAWS the picture
      @image = Image.new(x: adjusted_x_position, y: adjusted_y_position, path: path)
    end

    def resize_image
      if full_screen
        set_image_dimensions($screen.width, $screen.height)
      else
        set_image_dimensions(adjusted_width, adjusted_height)
      end
    end

    def set_image_dimensions(new_width, new_height)
      @image.width, @image.height = new_width, new_height
    end
  end
end
