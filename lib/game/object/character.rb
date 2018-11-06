class Game::Object::Character < Game::Object::Base

  # À bouger dans un module pour les autres objets qui auront des dialogues (??)
  def dialogue
    Game::Object::Dialogue.new(key)
  end

  # Idem ?
  def description
    Game::Object::Description.new(key)
  end

end
