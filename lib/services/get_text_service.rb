class GetTextService < GetResourceService

  representing_resource :text

  def call
    resource_class.new(settings)
  end

end