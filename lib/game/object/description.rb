class Game::Object::Description < Game::Object::Base

  def sentences
    (data[:sentences] || []).map do |sentence_key|
      Game::Object::Sentence.new(sentence_key)
    end
  end

end
