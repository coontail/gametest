class GameObject::InventoryItem < GameObject::Base

  # Idem ?
  def description
    GameObject::Description.new(key)
  end

end