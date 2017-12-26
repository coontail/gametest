class GameObject::Character < GameObject::Base

  # À bouger dans un module pour les autres objets qui auront des dialogues (??)
  def dialogue
    GameObject::Dialogue.new(key)
  end

  # Idem ?
  def description
    GameObject::Description.new(key)
  end

end