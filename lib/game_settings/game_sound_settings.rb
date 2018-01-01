module GameSettings
  class GameSoundSettings

    def self.sentences
      {

        ### Merchant ###

        merchant_sentence_1: {
          sound_path: "./data/dialogues/merchant/sentences/1.ogg"
        },

        merchant_sentence_2: {
          sound_path: "./data/dialogues/merchant/sentences/2.ogg"
        },

        merchant_sentence_3: {
          sound_path: "./data/dialogues/merchant/sentences/3.ogg"
        },

        merchant_sentence_4: {
          sound_path: "./data/dialogues/merchant/sentences/4.ogg"
        },

        merchant_sentence_5: {
          sound_path: "./data/dialogues/merchant/sentences/5.ogg"
        },

        merchant_sentence_6: {
          sound_path: "./data/dialogues/merchant/sentences/6.ogg"
        },

        merchant_sentence_7: {
          sound_path: "./data/dialogues/merchant/sentences/7.ogg"
        },

        # Merchant - Choices

        merchant_sentence_with_choices_1: {
          sound_path: "./data/dialogues/merchant/default.ogg"
        },

        # Merchant - Choice answers

        merchant_choice_answer_1: {
          sound_path: "./data/dialogues/merchant/choices/1_1.ogg"
        },

        merchant_choice_answer_2: {
          sound_path: "./data/dialogues/merchant/choices/1_2.ogg"
        },

        merchant_choice_answer_3: {
          sound_path: "./data/dialogues/merchant/choices/1_3.ogg"
        }
      }
    end


    def self.descriptions
      {
        merchant: {
          sound_path: "./data/descriptions/merchant.ogg"
        },

        old_lady: {
          sound_path: "./data/descriptions/old_lady.ogg"
        }
      }
    end

  end
end