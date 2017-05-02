class Gameplay

  def self.map
    {
      scene1: {
        image_path: "./data/images/h",
        events: {
          left: { end_scene: :scene2 },
          right: { end_scene: :scene3 }
        }   
      },

      scene2: {
        image_path: "./data/images/g",
        events: {
          left:  { end_scene: :scene4 },
          right:  { end_scene: :scene1 }
        }   
      },

      scene3: {
        image_path: "./data/images/d",
        events: {
          left: { end_scene: :scene1 },
          right: { end_scene: :scene4 }
        }
      },

      scene4: {
        image_path: "./data/images/b",
        character: :merchant,
        events: {
          left: { end_scene: :scene3 },
          right: { end_scene: :scene2 }
        }
      }
    }
  end

  def self.characters
    {
      merchant: {
        image_path: "./data/characters/merchant.png",
        dialogue: :merchant
      }
    }
  end

  def self.sfx
    {
      clicking: Sound.new("./data/sfx/click.wav"),
      cough: Sound.new("./data/sfx/cough.wav")
    }
  end

  def self.musics
    {
      main: Music.new("./data/musics/music_1.ogg"),
      alternate: Music.new("./data/musics/music_2.mp3")
    }
  end


  def self.menus
    {
      [[860,630], [960, 650]]  => {
        text: "Aller vers",
        action: :go_to,
        cursor_path: "./lib/data/images/go_to.png"
      },

      [[820, 670], [905,690]] => {
        text: "Regarder",
        action: :look,
        cursor_path: "./lib/data/images/eye.png"
      },

      [[930, 670], [990, 690]] => {
        text: "Parler",
        action: :talk_to,
        cursor_path: "./lib/data/images/mouth.png"
      },

      [[820, 710], [900, 730]] => {
        text: "Prendre",
        action: :take,
        cursor_path: "./lib/data/images/take.png"
      },
      
      [[930, 710], [1000, 730]] => {
        text: "Donner",
        action: :give,
        cursor_path: "./lib/data/images/give.png"
      }
    }
  end

  def self.dialogues
    {
      merchant: {
        default: "Salut l'etranger, que fais-tu ici ?",
        default_sound_path: "./data/dialogues/dial_1.ogg",
        choices: {
          choice_1: {
            text: "Je ne sais pas trop, pour etre honnete...",

            sentences: [
              {
                text: "J'ai plein de marchandises a te proposer !",
                sound_path: "./data/dialogues/dial_2.ogg",
                source: "character"
              },

              {
                text: "Ah oui ? Quel type de marchandises ?",
                source: "self"
              },

              {
                text: "Petit curieux va, ça ne te regarde pas",
                source: "character"
              },

              { 
                text: "Allez, file, du balai !",
                source: "character"
              },

              {
                text: "Pas très aimable...",
                source: "self"
              }
            ]
          },

          choice_2: {
            text: "En quoi ca vous regarde ?",

            sentences: [
              {
                text: "Tout doux mec, je veux pas d'ennuis moi",
                source: "character"
              }
            ]
          },

          choice_3: {
            text: "Au revoir",

            sentences: [
              {
                text: "Salut l'ami !",
                source: "character"
              }
            ]
          }
        }

      }
    }
  end


end