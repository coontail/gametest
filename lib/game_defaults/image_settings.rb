module GameDefaults
  class ImageSettings

    # When looking for image settings, GameImage will look for default image settings first,
    # and merge them with gameobject's data-defined settings if present.
    #
    # GameImage will first look for hash[object_key], and will use settings hash as a whole if not present.

    def self.characters
      {
        x_position: 200,
        y_position: 150,
        width: 300,
        height: 450
      }
    end

    def self.dialogue_thumbnails
      {
        x_position: 16,
        y_position: 600,
        width: 130,
        height: 150
      }
    end
    
    def self.direction_arrows
      {
        left: {
          x_position: 10, 
          y_position: 265,
          width: 32,
          height: 32,
          image_path: "./data/images/sprites/left_arrow.png"
        }, 

        right: {
          x_position: 730, 
          y_position: 265,
          width: 32,
          height: 32,
          image_path: "./data/images/sprites/right_arrow.png"
        },

        forward: {
          x_position: 375, 
          y_position: 270,
          width: 32,
          height: 32,
          image_path: "./data/images/sprites/up_arrow.png"
        },

        back: {
          x_position: 375, 
          y_position: 530,
          width: 32,
          height: 32,
          image_path: "./data/images/sprites/down_arrow.png"
        } 

      }
    end

    def self.scenes
      {
        x_position: 0,
        y_position: 0,
        width: 800,
        height: 600
      }
    end

    def self.overlays
      {
        x_position: 0,
        y_position: 0
      }
    end

  end
end
