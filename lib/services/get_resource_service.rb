class GetResourceService

  def initialize(game_object, options={})
    @game_object = game_object
    @options = options
  end

  protected

  def self.representing_resource(resource_name)
    @@represented_resource = resource_name
  end

  def represented_resource
    @@represented_resource
  end

  private

  def game_object_class_name
    @options[:game_object_class_name] || @game_object.class.name
  end

  def custom_class
    @options[:custom_class] || "#{represented_resource}::#{game_object_class_name}"
  end

  def storage_method
    @options[:storage_method] || "#{game_object_class_name.underscore}s"
  end

  def storage_module
    @options[:storage_module] || "GameDefaults::#{represented_resource}Settings"
  end

  def resource_class
    if Object.const_defined?(custom_class)
      Object.const_get(custom_class)
    else
      "#{represented_resource}::Base"
    end
  end

  def default_settings
    @default_settings ||= GetDefaultSettingsService.new(storage_module, storage_method, @game_object.key).call
  end


end