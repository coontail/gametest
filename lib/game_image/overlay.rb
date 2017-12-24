class GameImage::Overlay < GameImage::Base

  private
  
  def resize_image
    @image.width = $screen.width
    @image.height = $screen.height
  end

end