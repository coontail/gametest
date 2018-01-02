class GetSettingsService 

  def initialize(storage_resource_key, storage_class_key, object_key)
    @storage_resource_key = storage_resource_key
    @storage_class_key = storage_class_key
    @object_key = object_key
  end

  def call
    default_settings.merge(object_specific_settings)
  end

  private

  def object_specific_settings
    class_settings[@object_key] || {}
  end

  def default_settings
    class_settings[:defaults] || {}
  end

  def class_settings
    @class_settings ||= $settings.get_deep(:game_settings, @storage_resource_key, @storage_class_key) || {}
  end

end