class GetResourceService

  def initialize(game_object, options={})
    @game_object = game_object
    @options = options
  end

  # Macro definition
  
  class << self
    attr_accessor :represented_resource

    def representing_resource(resource_name)
      @represented_resource = resource_name
    end
  end

  def represented_resource
    self.class.represented_resource
  end

  private

  def identifier_method
    @options[:identifier_method] || :key
  end

  def identifier
    @game_object.send(identifier_method)
  end

  def game_object_class_name
    @options[:game_object_class_name] || @game_object.class.name.demodulize
  end

  # Resource class that should be init
  def custom_class
    @options[:custom_class] || "#{represented_resource}::#{game_object_class_name}"
  end

  def storage_method
    @options[:storage_method] || "#{game_object_class_name.demodulize.underscore}s"
  end

  def storage_module
    @options[:storage_module] || "GameSettings::#{represented_resource}Settings"
  end

  def resource_class
    if Object.const_defined?(custom_class)
      Object.const_get(custom_class)
    else
      Object.const_get("#{represented_resource}::Base")
    end
  end

  def settings
    @default_settings ||= GetSettingsService.new(storage_module, storage_method, identifier).call
  end

end