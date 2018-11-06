class Game::Object::InventoryItem < Game::Object::Base

  # Idem ?
  def description
    Game::Object::Description.new(key)
  end

end
