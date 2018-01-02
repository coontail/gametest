class GetImageService < GetResourceService

  representing_resource :image

  def call
    resource_class.new(settings)
  end

  # private

  # def image_settings
  #   {}.merge(settings).tap do |settings|
  #     settings[:image_path] ||= @game_object.data[:image_path]
  #   end
  # end

end