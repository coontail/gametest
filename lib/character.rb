class Character

  attr_reader :data
  attr_reader :key
  attr_reader :hitbox

  def initialize(character_key)
    @character_key = character_key
    @data = game_characters[@character_key]
  end

  # def draw
  #   image.draw && set_hitbox
  # end

  private

  # def image
  #   @image ||= Image::Character.new(image_settings, path: @data[:image_path])
  # end

  # def image_settings
  #   {
  #     x_position: 200,
  #     y_position: 150,
  #     width: 300,
  #     height: 450
  #   }
  # end

  # def set_hitbox
  #   @hitbox = [
  #     [image.x_position, image.y_position], 
  #     [image.x_position + image.width, image.y_position + image.height]
  #   ]     
  # end

  def game_characters
    @game_characters ||= Gameplay.characters
  end

end