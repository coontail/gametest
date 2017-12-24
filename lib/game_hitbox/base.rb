module GameHitbox
  class Base
    include Scalable

    attr_reader :x1_position, :x2_position, :y1_position, :y2_position
    
    def initialize(settings={})
      @x1_position = settings[:x1_position]
      @x2_position = settings[:x2_position]
      @y1_position = settings[:y1_position]
      @y2_position = settings[:y2_position]
    end

    def is_touched_by?(pointer_x, pointer_y)
      xp >= adjust_to_ratio(x1_position) &&
      xp <= adjust_to_ratio(x2_position) &&
      yp >= adjust_to_ratio(y1_position) &&
      yp <= adjust_to_ratio(y2_position) 
    end

  end
end