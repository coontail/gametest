class GetImageService < GetResourceService

  representing_resource 'GameImage'

  def call
    resource_class.new(image_settings)
  end

  private

  def image_settings
    {}.merge(settings).tap do |settings|
      settings[:image_path] ||= @game_object.data[:image_path]
    end
  end

end