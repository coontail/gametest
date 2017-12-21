class Image::Overlay < Image::Base

  def resize_image
    @image.width = $screen.width
    @image.height = $screen.height
  end

end