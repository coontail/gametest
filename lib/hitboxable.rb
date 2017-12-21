module Hitboxable

  def self.included(base)

    def set_hitbox
      @hitbox ||= hitbox_coordinates || calculate_hitbox_coordinates
    end

    def calculate_hitbox_coordinates
      [
        [image.x_position, image.y_position], 
        [image.x_position + image.width, image.y_position + image.height]
      ]     
    end

    def hitbox_coordinates;end

    base.class_eval do
      attr_reader :hitbox
    end
  end

end


  def draw
    image.draw && set_hitbox
  end

  def image
    @image ||= Image::Character.new(image_settings, path: @data[:image_path])
  end

  def image_settings
    {
      x_position: 200,
      y_position: 150,
      width: 300,
      height: 450
    }
  end

