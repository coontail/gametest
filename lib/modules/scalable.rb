module Scalable
  
  def included(base)
    
    def adjust_to_ratio(size)
      (size * $screen.ratio).to_i
    end

  end

end