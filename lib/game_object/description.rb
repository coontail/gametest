class GameObject::Description < GameObject::Base

  def sentences
    (data[:sentences] || []).map do |sentence_key|
      GameObject::Sentence.new(sentence_key)
    end
  end

end
