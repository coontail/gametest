module GameSettings
  class GameImageSettings

    # When looking for image settings, GameImage will look for default image settings first,
    # and merge them with gameobject's data-defined settings if present.
    #
    # GameImage will first look for hash[object_key], and will use settings hash as a whole if not present.

    def self.characters
      {
        defaults: {
          x_position: 200,
          y_position: 150,
          width: 300,
          height: 450
        },

        merchant: {
          image_path: "./data/characters/merchant.png"
        },

        merchant_2: {
          image_path: "./data/characters/merchant2.png"        
        },

        player: {
          image_path: "./data/characters/player.png"
        }

      }
    end

    def self.dialogue_thumbnails
      {
        defaults: {
          x_position: 16,
          y_position: 600,
          width: 130,
          height: 150
        }
      }
    end
    
    def self.direction_arrows
      {
        defaults: {
          width: 32,
          height: 32
        },

        left: {
          x_position: 10, 
          y_position: 265,
          image_path: "./data/images/sprites/left_arrow.png"
        }, 

        right: {
          x_position: 755, 
          y_position: 265,
          image_path: "./data/images/sprites/right_arrow.png"
        },

        forward: {
          x_position: 380, 
          y_position: 270,
          image_path: "./data/images/sprites/up_arrow.png"
        },

        back: {
          x_position: 380, 
          y_position: 530,
          image_path: "./data/images/sprites/down_arrow.png"
        } 

      }
    end

    def self.scenes
      {
        defaults: {
          x_position: 0,
          y_position: 0,
          width: 800,
          height: 600
        },

        scene_1: {
          image_path: "./data/images/scenes/1.png"
        },

        scene_2: {
          image_path: "./data/images/scenes/2.png"
        },

        scene_3: {
          image_path: "./data/images/scenes/3.png"
        },

        scene_4: {
          image_path: "./data/images/scenes/4.png"
        },

        scene_5: {
          image_path: "./data/images/scenes/5.png"
        }
      }
    end

    def self.overlays
      {
        defaults: { full_screen: true },

        main: {
          image_path: "./data/images/assets/background.png"
        }

      }
    end

  end
end