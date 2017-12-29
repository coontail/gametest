module GameText
  class Base
    include Scalable

    DEFAULT_FONT = "./data/fonts/andersans.ttf"

    attr_accessor :x_position, :y_position, :body, :size, :color, :font

    def initialize(settings={})
      @x_position = settings[:x_position]
      @y_position = settings[:y_position]
      @body       = settings[:body]
      @size       = settings[:size]
      @color      = settings[:color]
      @font       = settings[:font] || DEFAULT_FONT
    end

    def write
      Text.new(settings)
    end

    %w(x_position y_position).each do |attribute|
      define_method("adjusted_#{attribute}") { adjust_to_ratio send(attribute) }
    end

    private

    def settings
      {
        x: adjusted_x_position, 
        y: adjusted_y_position, 
        text: body, 
        size: size, 
        font: font,
        color: color
      }
    end

  end
end