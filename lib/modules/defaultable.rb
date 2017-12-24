# module Defaultable
#   def self.included(base)

#     def default_settings_for(key)
#       settings = defaultable_storage_module.send(defaultable_method_name)
#       settings[key] || settings
#     end

#     define_method("default_#{base.name.downcase}_settings") do
#       variable_name = "default_#{base.name.downcase}_settings"

#       instance_variable_get("@#{variable_name}") || 
#       instance_variable_set("@#{variable_name}", default_settings_for(key) )
#     end

#     def defaultable_storage_module
#       raise Error, 'You should override defaultable_storage_module method in containing module'
#     end
#   end
# end

# module ImageSettings
  
#   def self.direction_arrows
#     {
#      caca: {
#       lol: 51,
#       truc: 71
#      },

#      toto: 5,
#      tutu: 6
#     }
#   end

#   def self.totos
#     {
#      toto: 9,
#      tutu: 15
#     }
#   end

# end

# module Truc
  
#   def self.direction_arrows
#     {
#      caca: {
#       lol: 'truc',
#       truc: 'lol'
#      },

#      toto: 'b',
#      tutu: 8
#     }
#   end

#   def self.totos
#     {
#      toto: 9,
#      tutu: 15
#     }
#   end

# end








# module Imageable
#   class Error < StandardError;end

#   include Defaultable

#   def self.included(base)

#     def image
#       @image ||= image_class.new(settings: image_settings, path: image_path)
#     end

#     def image_path
#       if self.respond_to? :data
#         data[:image_path]
#       else
#         raise_imageable_error
#       end
#     end

#     def custom_image_class
#       "Image::#{self.class.name}"
#     end

#     def image_class
#       if Object.const_defined?(custom_image_class)
#         Object.const_get(custom_image_class)
#       else
#         'Image::Base'
#       end
#     end

#     def raise_imageable_error
#       raise Error, 'Imageable is meant to be used with Gameplayable.'
#     end

#     def defaultable_storage_module
#     end

#     def image_settings
#       GetDefaultSettingsService.new('GameDefaults::ImageSettings',)
#     end

#   end
# end





# module Imageable  
#   def self.included(base)

#     def image_settings
#       GetDefaultSettingsService.new('GameDefaults::ImageSettings', '', :caca)
#     end
#   end
# end

# module Truc
  
#   def self.included(base)

#     def truc
#       puts 'truc !'
#       puts default_truc_settings
#     end
    
#     def defaultable_storage_module
#       Trucs
#     end
#   end
# end


# class Georges
#   include Imageable
#   include Truc

#   attr_reader :key

#   def initialize(key)
#     @key = key
#   end
# end

# class Pierre < Georges
#   def defaultable_method_name
#     'direction_arrows'
#   end
# end