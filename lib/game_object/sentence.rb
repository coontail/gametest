class GameObject::Sentence < GameObject::Base

  def choices
    (data[:choices] || []).map do |choice_key|
      GameObject::Choice.new(choice_key)
    end
  end

  def given_item
    data[:given_item]
  end

  def image_options
    { identifier_method: :source }
  end

  def source
    data[:source]
  end

end