class Direction

  attr_reader :direction_key
  attr_reader :hitbox

  def initialize(direction_key)
    @direction_key = direction_key
    @data = game_directions[@direction_key]
  end

  def draw
    image.draw && set_hitbox
  end

  private

  def image
    @image ||= Image::DirectionArrow.new(image_settings, path: @data[:image_path])
  end

  def image_settings
    { width: 32, height: 32 }.merge(@data[:image_coordinates])
  end

  def set_hitbox
    @hitbox ||= @data[:hitbox_coordinates]
  end

  def game_directions
    @game_directions ||= Gameplay.game_directions
  end

end