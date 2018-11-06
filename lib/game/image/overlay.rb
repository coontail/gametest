class Game::Image::Overlay < Game::Image::Base

  private

  def resize_image
    @image.width = $screen.width
    @image.height = $screen.height
  end

end
