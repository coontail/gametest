module GameSettings
  class GameTextSettings

    def self.menu_items
      {
        go_to: {
          body: 'Aller vers',
          x_position: 860,
          y_position: 630
        },

        look_at: {
          body: 'Regarder',
          x_position: 820,
          y_position: 670
        },
        
        talk_to: {
          body: 'Parler à',
          x_position: 930,
          y_position: 670
        },

        take: {
          body: 'Prendre',
          x_position: 820,
          y_position: 710
        },

        give: {
          body: 'Donner',
          x_position: 930,
          y_position: 710
        }
      }
    end

    def self.sentences
      {
        defaults: {
          x_position: 175,  
          y_position: 615
        }, 

        ### Merchant ###
        
        merchant_sentence_1: {
          body: "J'ai plein de marchandises a te proposer !"
        },

        merchant_sentence_2: {
          body: "Ah oui ? Quel type de marchandises ?"
        },

        merchant_sentence_3: {
          body: "Petit curieux va, ca ne te regarde pas"
        },

        merchant_sentence_4: {
          body: "Allez, file, du balai !"
        },

        merchant_sentence_5: {
          body: "Pas tres aimable..."
        },

        merchant_sentence_6: {
          body: "Tout doux mec, je veux pas d'ennuis moi"
        },

        merchant_sentence_7: {
          body: "Salut l'ami !"
        },
        
        # Merchant - Choices

        merchant_sentence_with_choices_1: {
          body: "Salut l'etranger, que fais-tu ici ?"
        },

        # Merchant - Choice answers

        merchant_choice_answer_1: {
          body: "Je ne sais pas trop, pour etre honnete..."
        },

        merchant_choice_answer_2: {
          body: "En quoi ca vous regarde ?"
        },

        merchant_choice_answer_3: {
          body: "Au revoir"
        }
      }
    end

    def self.descriptions
      {
        defaults: {
          x_position: 175,  
          y_position: 615
        }, 

        merchant: {
          body: "C'est un vieux marchand obese avec une veste de riche sur l'epaule"
        }
      }
    end

    # choice_NUMBER is an abstract key used to set the choice sentence text position & hitbox
    def self.choices
      {
        choice_1: {
          x_position: 175,
          y_position: 665
        },

        choice_2: {
          x_position: 175,
          y_position: 690
        },

        choice_3: {
          x_position: 175,
          y_position: 715
        }
      }
    end

  end
end