class GetTextService < GetResourceService

  representing_resource 'GameText'

  def call
    resource_class.new(default_settings)
  end

end