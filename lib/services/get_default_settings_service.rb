class GetDefaultSettingsService 

  def initialize(storage_module, storage_method, key)
    @storage_module = storage_module
    @storage_method = storage_method
    @key = key
  end

  def call
    default_settings
  end

  private

  def default_settings
    settings[key] || settings
  end

  def settings
    @settings ||= Object.const_get(storage_module).send(storage_method)
  end

end