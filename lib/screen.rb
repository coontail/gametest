class Screen

  DEFAULT_WIDTH = 1024.freeze
  
  attr_reader :width
  attr_reader :height
  attr_reader :ratio

  def initialize(width:, height:)
    @width = width
    @height = height
    @ratio = @width / DEFAULT_WIDTH.to_f
  end

end