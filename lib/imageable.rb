module Imageable
  def self.included(base)

    def 
    def image
      @image ||= Image.new(image_settings, path: @data[:image_path])
    end

    def draw
      image.draw && set_hitbox
    end

    def hitbox
      @hitbox ||= hitbox_coordinates || calculate_hitbox_coordinates
    end

    def calculate_hitbox_coordinates
      [
        [image.x_position, image.y_position], 
        [image.x_position + image.width, image.y_position + image.height]
      ]     
    end

    def hitbox_coordinates;end
    def image_settings;end
  end
end

  # def image_settings
  #   {
  #     x_position: 200,
  #     y_position: 150,
  #     width: 300,
  #     height: 450
  #   }
  # end

