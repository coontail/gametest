class GetSoundService < GetResourceService

  representing_resource 'GameSound'

  def call
    resource_class.new(settings)
  end

end
