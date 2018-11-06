class GetResourceService

  include Representable

  def initialize(game_object, options={})
    @game_object = game_object
    @options = options
  end

  private

  ########### Identifiers #############

  def identifier_method
    @options[:identifier_method] || :key
  end

  def object_key
    @game_object.send(identifier_method)
  end

  ########### Dynamic identifiers ###########

  def dynamic_identifier_method
    @options[:dynamic_identifier_method] || :dynamic_key
  end

  def dynamic_key
    @game_object.send(dynamic_identifier_method)
  end

  ########### Class names ###########

  def resource_class_name
    @options[:resource_class_name] || "Game::#{represented_resource.capitalize}"
  end

  def game_object_class_name
    @options[:game_object_class_name] || @game_object.class.name.demodulize
  end

  def custom_class
    @options[:custom_class] || "#{resource_class_name}::#{game_object_class_name}"
  end

  def resource_class
    if Object.const_defined?(custom_class)
      Object.const_get(custom_class)
    else
      Object.const_get("#{resource_class_name}::Base")
    end
  end

  ########### Settings ###########

  def class_key
    @options[:class_key] || "#{game_object_class_name.demodulize.underscore}s".to_sym
  end

  def resource_key
    @options[:resource_key] || represented_resource
  end

  def settings
    @settings ||= GetSettingsService.new(
      resource_key: resource_key,
      class_key:    class_key,
      dynamic_key:  dynamic_key,
      object_key:   object_key
    ).call
  end

end
