class GameObject::Dialogue < GameObject::Base
  
  def sentences
    (data[:sentences] || []).map do |sentence_key|
      GameObject::Sentence.new(sentence_key)
    end
  end

  # def choice
  #   choice_key = data[:choices]
    
  #   if choice_key
  #     GameObject::Choice.new(choice_key)
  #   end
  # end

end