class Exposers::GameplayExposer

  # expose(:choices_coordinates)    { Gameplay.choices_coordinates }
  # expose(:game_choices)           { Gameplay.choices }
  # expose(:game_sentences)         { Gameplay.sentences }
  # expose(:game_descriptions)      { Gameplay.descriptions }
  # expose(:game_menus)             { Gameplay.menus }
  # expose(:game_dialogues)         { Gameplay.dialogues }
  # expose(:game_characters)        { Gameplay.characters }
  # expose(:game_sfx)               { Gameplay.sfx }
  # expose(:game_sprites)           { Gameplay.sprites }
  # expose(:game_map)               { Gameplay.map }

  def music
    @music ||= GameMusic.new
  end

end