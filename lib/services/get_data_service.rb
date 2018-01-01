class GetDataService < GetResourceService

  representing_resource 'Data'

  def call
    get_data
  end

  private
    
  def get_data
    if Gameplay.respond_to?(storage_method)
      Gameplay.send(storage_method)[@game_object.key] || {}
    else
      {}
    end
  end

end
