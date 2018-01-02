module Gameplay

#   def self.scenes
#     {
#       scene_1: {
#         events: {
#           left:  { end_scene: :scene_3 },
#           right: { end_scene: :scene_2 }
#         }   
#       },

#       scene_2: {
#         character: :merchant,
#         events: {
#           left:   { end_scene: :scene_1 },
#           right:  { end_scene: :scene_3 }
#         }   
#       },

#       scene_3: {
#         events: {
#           left:    { end_scene: :scene_2 },
#           right:   { end_scene: :scene_1 },
#           forward: { end_scene: :scene_4 }
#         }
#       },

#       scene_4: {
#         events: {
#           back:    { end_scene: :scene_3 },
#           forward: { end_scene: :scene_5 }
#         }
#       },

#       scene_5: {
#         character: :merchant_2,
#         events: {
#           left: { end_scene: :scene_8 },
#           right: { end_scene: :scene_6 },
#           back: { end_scene: :scene_4 }
#         }
#       },

#       scene_6: {
#         events: {
#           left: { end_scene: :scene_5 },
#           forward: { end_scene: :scene_7 }
#         }
#       },

#       scene_7: {
#         character: :old_lady,
#         events: {
#           back: { end_scene: :scene_6 }
#         }
#       },

#       scene_8: {
#         events: {
#           right: { end_scene: :scene_5 },
#           forward: { end_scene: :scene_9 }
#         }
#       },

#       scene_9: {
#         events: {
#           forward: { end_scene: :scene_10 }
#         }
#       },

#       scene_10: {
#         events: {
#           forward: { end_scene: :scene_1 }
#         }
#       }

#     }
#   end

#   def self.sfx
#     {
#       clicking: {
#         sound_path: "./data/sfx/click.wav"
#       },

#       cough: {
#         sound_path: "./data/sfx/cough.wav"
#       }
#     }
#   end

#   def self.musics
#     {
#       main: {
#         music_path: "./data/musics/music_1.ogg"
#       },

#       alternate: {
#         music_path: "./data/musics/music_2.mp3"
#       }
#     }
#   end

#   def self.sentences
#     {

#       ##### Merchant ####

#       merchant_sentence_1: {
#         source: :merchant
#       },

#       merchant_sentence_2: {
#         source: :self
#       },

#       merchant_sentence_3: {
#         source: :merchant
#       },

#       merchant_sentence_4: {
#         source: :merchant
#       },

#       merchant_sentence_5: {
#         source: :self
#       },

#       merchant_sentence_6: {
#         source: :merchant
#       },

#       merchant_sentence_7: {
#         source: :merchant
#       },

#       ## Merchant - Choices ##

#       merchant_sentence_with_choices_1: {
#         source: :merchant,
#         choices: [
#           :merchant_choice_1,
#           :merchant_choice_2,
#           :merchant_choice_3
#         ]
#       },

#       ## Merchant - Choice answers ##

#       merchant_choice_answer_1: {
#         source: :self
#       },

#       merchant_choice_answer_2: {
#         source: :self
#       },

#       merchant_choice_answer_3: {
#         source: :self
#       }

#     }
#   end

#   # A sentence can have multiple choices.
#   # Those choices are used to feed & replace current_sentences with more sentences.
#   # It's pretty much like dialogues, except choices are interactive.
#   # Position => Where the choice should be in the choice list
#   # Display_sentence => What sentence should be displayed. It is also added as the first sentence
#   # in the sentences list
#   def self.choices
#     {
#       merchant_choice_1: {
#         position: :choice_1,
#         display_sentence: :merchant_choice_answer_1,

#         sentences: [
#           :merchant_sentence_1,
#           :merchant_sentence_2,
#           :merchant_sentence_3,
#           :merchant_sentence_4,
#           :merchant_sentence_5
#         ]
#       },

#       merchant_choice_2: {
#         position: :choice_2,
#         display_sentence: :merchant_choice_answer_2,

#         sentences: [
#           :merchant_sentence_6
#         ]
#       },

#       merchant_choice_3: {
#         position: :choice_3,
#         display_sentence: :merchant_choice_answer_3,

#         sentences: [
#           :merchant_sentence_7
#         ]
#       }
#     }
#   end


#   # Dialogues are characters base sentences
#   def self.dialogues
#     {
#       # merchant: {
#       #   choice: :merchant_choices_1
#       # },

#       merchant: {
#         sentences: [
#           :merchant_sentence_4,
#           :merchant_sentence_5,
#           :merchant_sentence_7
#         ]
#         },

#       merchant_2: {
#         sentences: [
#           :merchant_sentence_with_choices_1
#         ]
#       }
#     }
#   end
end