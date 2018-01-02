class GetSoundService < GetResourceService

  representing_resource :sound

  def call
    resource_class.new(settings)
  end

end
