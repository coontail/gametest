class GetSettingsService 

  def initialize(storage_module, storage_method, key)
    @storage_module = storage_module
    @storage_method = storage_method
    @key = key
  end

  def call
    default_settings.merge(object_specific_settings)
  end

  private

  def object_specific_settings
    class_settings[@key] || {}
  end

  def default_settings
    class_settings[:defaults] || {}
  end

  def class_settings
    @class_settings ||= call_storage_method || {}
  end

  def call_storage_method
    _storage_method = @storage_method
    _storage_module = Object.const_get(@storage_module) if Object.const_defined?(@storage_module)
    
    if _storage_module && _storage_module.respond_to?(_storage_method)
      _storage_module.send(_storage_method) 
    end
  end

end