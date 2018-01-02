# TODO : clean that
class GetDataService < GetResourceService

  representing_resource :data

  def call
    get_data
  end

  private
    
  def get_data
    $settings.get_deep(:game_settings, settings_resource_key, settings_class_key, @game_object.key) || {}
  end

end
