class GetMusicService < GetResourceService

  representing_resource :music

  def call
    resource_class.new(settings)
  end

end
