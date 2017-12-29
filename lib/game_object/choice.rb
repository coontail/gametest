class GameObject::Choice < GameObject::Base
  # By far the worst game object, needs cleaner version asap, config is too obscure, kinda

  def sentences
    _sentences = (data[:sentences] || []).map do |sentence_key|
      GameObject::Sentence.new(sentence_key)
    end

    _sentences.unshift display_sentence
  end

  def text
    super.tap do |game_text|
      game_text.body = display_sentence.text.body
    end
  end

  def display_sentence 
    @display_sentence ||= GameObject::Sentence.new(data[:display_sentence])
  end

  ### Options ###

  def text_options
    { identifier_method: :position }
  end

  def hitbox_options
    { identifier_method: :position }
  end

  def position
    data[:position]
  end

end