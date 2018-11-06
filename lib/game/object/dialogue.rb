class Game::Object::Dialogue < Game::Object::Base

  def sentences
    (data[:sentences] || []).map do |sentence_key|
      Game::Object::Sentence.new(sentence_key)
    end
  end

  def choice
    choice_key = data[:choices]

    if choice_key
      Game::Object::Choice.new(choice_key)
    end
  end

end
