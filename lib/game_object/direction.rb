class GameObject::Direction < GameObject::Base

  private

  def image_options
    { game_object_class_name: 'DirectionArrow' }
  end

end