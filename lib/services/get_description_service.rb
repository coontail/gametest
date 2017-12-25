class GetDescriptionService < GetResourceService

  representing_resource 'GameText'

  def call
    resource_class.new(settings)
  end

end