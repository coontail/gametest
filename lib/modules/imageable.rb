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
#       GameDefaults::ImageSettings
#     end

#     def image_settings
#       default_imageable_settings
#     end

#   end
# end



