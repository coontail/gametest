class Game::Object::Sentence < Game::Object::Base

  def choices
    (data[:choices] || []).map do |choice_key|
      Game::Object::Choice.new(choice_key)
    end
  end

  def given_item
    data[:given_item]
  end

  def image_options
    { identifier_method: :thumbnail }
  end

  def thumbnail
    data[:thumbnail]
  end

end
