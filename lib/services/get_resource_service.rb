class GetResourceService
  # À refacto, since c'est la classe un peu centrale a tout
  
  def initialize(game_object, options={})
    @game_object = game_object
    @options = options
  end

  ######### Move that in a module plz vvv#########
  ############# Macro definition #################
  
  class << self
    attr_accessor :represented_resource

    def representing_resource(resource_name)
      @represented_resource = resource_name
    end
  end

  def represented_resource
    self.class.represented_resource
  end

  ############################################

  private

  def resource_class_name
    @options[:resource_class_name] || "Game#{represented_resource.capitalize}"
  end

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
    @options[:custom_class] || "#{resource_class_name}::#{game_object_class_name}"
  end

  # Settings path config
  def settings_class_key
    @options[:settings_class_key] || "#{game_object_class_name.demodulize.underscore}s".to_sym
  end

  def settings_resource_key
    @options[:settings_resource_key] || represented_resource
  end

  def resource_class
    if Object.const_defined?(custom_class)
      Object.const_get(custom_class)
    else
      Object.const_get("#{resource_class_name}::Base")
    end
  end

  def settings
    @settings ||= GetSettingsService.new(settings_resource_key, settings_class_key, identifier).call
  end

end