class GameObject::Scene < GameObject::Base

  def events
    data[:events] || {}
  end

  def next_scene_for(event_key)
    next_scene_key = events.get_deep(event_key, :end_scene)
    self.class.new(next_scene_key) if next_scene_key
  end

end