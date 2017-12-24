# module Gameplayable
#   class Error < StandardError;end

#   def self.included(base)
    
#     def data
#       @data ||= get_data
#     end

#     def get_data
#       if Gameplay.respond_to?(data_storage_method)
#         Gameplay.send(data_storage_method)[key]
#       else
#         raise_gameplayable_error
      
#     end

#     def data_storage_method
#       "game_#{self.class.name.downcase}s".to_sym
#     end

#     def raise_gameplayable_error
#       raise Error, "no storage method #{data_storage_method} was found in Gameplay"
#     end

#   end
# end
