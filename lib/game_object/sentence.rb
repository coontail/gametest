class GameObject::Sentence < GameObject::Base

  def image_options
    { identifier_method: :source }
  end

  def source
    data[:source]
  end

end