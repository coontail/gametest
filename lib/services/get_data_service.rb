# TODO : clean that
class GetDataService < GetResourceService

  representing_resource :data

  def call
    get_data
  end

  private
    
  def get_data
    $settings.get_deep(:game_settings, resource_key, class_key, object_key) || {}
  end

end
