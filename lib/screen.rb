class Screen

  attr_reader :width
  attr_reader :height
  attr_reader :ratio

  def initialize(width:, height:)
    @width = width
    @height = height
    @ratio = @width / Gameplay::GAME_WIDTH.to_f
  end

end