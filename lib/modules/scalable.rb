module Scalable
    
  def adjust_to_ratio(size)
    (size * $screen.ratio).to_i
  end

end