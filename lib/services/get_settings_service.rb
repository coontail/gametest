class GetSettingsService 

  def initialize(settings={})
    @resource_key = settings[:resource_key]
    @class_key    = settings[:class_key]
    @dynamic_key  = settings[:dynamic_key]
    @object_key   = settings[:object_key]
  end

  def call
    defaults = dynamic_default_settings.merge(default_settings)
    defaults.merge(object_specific_settings)
  end

  private

  def object_specific_settings
    class_settings[@object_key] || {}
  end

  def default_settings
    class_settings[:defaults] || {}
  end

  def dynamic_default_settings
    @dynamic_key ? class_settings.get_deep(:dynamics, @dynamic_key) || {} : {}
  end

  def class_settings
    @class_settings ||= $settings.get_deep(:game_settings, @resource_key, @class_key) || {}
  end

end