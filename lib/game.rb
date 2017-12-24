class Game

  # attr_accessor :mouse_x
  # attr_accessor :mouse_y
  # attr_accessor :frozen_until
  # attr_accessor :current_sentences

  # attr_reader :current_scene
  # attr_reader :current_scene_data
  # attr_reader :current_music
  # attr_reader :current_character
  # attr_reader :current_character_data
  # attr_reader :current_character_coordinates
  # attr_reader :current_sound
  # attr_reader :current_action
  # attr_reader :current_dialogue
  # attr_reader :current_dialogue_data

  def initialize(options={})
    @current_menu_items = init_menu_items
    @current_scene = :scene_1
    @frozen_until = Time.now
    @current_action = :go_to
    @current_sentences = []
    @directions = []

    update_scene
  end

  def init_menu_items
    [:go_to, :look_at, :talk_to, :take, :give].map do |key|
      GameObject::MenuItem.new(key)
    end
  end

  def update_scene
    @current_scene_data = game_map[@current_scene]

    update_music
    update_scene_image
    update_characters
    draw_direction_arrows
    update_overlay
    update_menu
  end

  # private

  def update_music
    music.update game_map[@current_scene][:music]
  end

  def update_scene_image
    screen.draw_scene(@current_scene_data[:image_path])
  end

  def update_characters
    key = @current_scene_data[:character]

    if key
      @current_character = Character.new(key)
      @current_character.image.draw
    else
      clear_character_info
    end
  end

  def clear_character_info
    @current_character = nil
    @current_dialogue = nil
    @current_dialogue_data = nil
  end

  def update_overlay
    key = @current_scene_data[:overlay] || :main

    @current_overlay = Overlay.new(key)
    @current_overlay.image.draw
  end

  def update_menu
    @current_menu_items.each do |menu_item|
      # color = (@current_action == v[:action] ? "black" : "white")
      menu_item.text.write
    end
  end

  def draw_direction_arrows
    map_events = @current_scene_data[:events]

    @directions = map_events.keys.map { |key| Direction.new(key) }
    @directions.each { |direction| direction.image.draw }
  end

  def get_event
    get_menu_event || 
    get_choice_event ||
    get_map_event || 
    get_character_event
  end

  def get_map_event
    map_events = @current_scene_data[:events]
  
    map_event = map_events.find do |direction_key, event|
      direction = @directions.find{ |direction| direction.key == direction_key }
      direction.hitbox.is_touched_by?(@mouse_x, @mouse_y)
    end

    if map_event
      { type: :direction }.merge(map_event.last)
    end
  end

  def get_menu_event
    menu_event = @current_menu_items.find do |menu_item|
      menu_item.hitbox.is_touched_by?(@mouse_x, @mouse_y)
    end

    if menu_event
      { type: :menu }.merge(menu_event.last)
    end
  end

  def get_choice_event
    if @current_dialogue_data
      choice_event = available_choices_coordinates.find do |coordinates, choice|
        is_in_rectangle?(*coordinates.flatten, @mouse_x, @mouse_y)
      end    

      if choice_event
        { type: :choice }.merge(choice_event.last)
      end

    end
  end

  def available_choices_coordinates
    if @current_dialogue_data[:choices]
        
      choices_key = @current_dialogue_data[:choices]
      choices_keys = game_choices[choices_key].keys

      choices_coordinates.select{ |coordinates, data| choices_keys.include?(data[:choice]) }
    else
      {}
    end
  end

  def get_character_event
    if @current_character && @current_character.hitbox.is_touched_by?(@mouse_x, @mouse_y)
      { type: :character }.merge(@current_character_data)
    end
  end

  def apply_event(event)

    if event[:type] == :menu
      @current_action = event[:action]
      update_menu
    end

    if event[:type] == :choice
      apply_choice(event[:choice])
    end

    case [event[:type], @current_action]

    when [:direction, :go_to]
      @current_scene = event[:end_scene]
      update_scene
      play_sfx(:clicking)

    when [:character, :talk_to]
      update_dialogues
    
    when [:character, :look_at]
      update_description(@current_character)
    end
  end

  def apply_choice(choice)
    choices_key = @current_dialogue_data[:choices]
    choice_data = game_choices[choices_key][choice]

    display_message(choice_data[:choice_text])
    display_thumbnail_for(:self)
    play_sound(choice_data[:choice_sound_path])

    @current_sentences = choice_data[:sentences].dup
  end

  def update_description(object)
    description_data = game_descriptions[object]

    if description_data
      display_message(description_data[:text])
      display_thumbnail_for(:self)
      play_sound(description_data[:sound_path])
    end
  end

  def update_sentences
    sentence_key = @current_sentences[0]
    sentence_data = game_sentences[sentence_key]

    if sentence_data[:choices]
      @current_dialogue_data = sentence_data ## ajouté en dernier, bugge encore, tester discussion avec merchant2
      update_choices
    else
      display_thumbnail_for(sentence_data[:source])
      display_message(sentence_data[:text])
      play_sound(sentence_data[:sound_path])
    end

    @current_sentences.shift
  end

  def update_dialogues
    if @current_character
      @current_dialogue = @current_character
      @current_dialogue_data = game_dialogues[@current_dialogue]

      if @current_dialogue_data
  
        if @current_dialogue_data[:choices]
          update_choices
        elsif @current_dialogue_data[:sentences]
          @current_sentences = @current_dialogue_data[:sentences].dup
        end
      
      else
        play_sfx(:cough)
      end
    end
  end

  def update_choices
    choices = game_choices[@current_dialogue_data[:choices]]

    display_thumbnail_for(:character)
    display_message(choices[:default_text])

    if choices[:default_sound_path]
      play_sound(choices[:default_sound_path])
    end
  
    displayable_choices = choices.reject{ |key| [:default_sound_path, :default_text].include?(key)}
    display_choices(displayable_choices)
  end

  def display_choices(choices)
    choices.each_with_index do |(choice_key, choice_data), index|
      build_text(*available_choices_coordinates.keys[index][0], choice_data[:choice_text], 17)
    end
  end

  # TODO : Faire une classe/module de Text comme pour hitbox et consorts
  def build_text(x, y, text, size, color="white")
    adjusted_x = adjust_to_ratio(x)
    adjusted_y = adjust_to_ratio(y)

    Text.new(adjusted_x, adjusted_y, text, size, "./data/fonts/andersans.ttf", color)
  end

  def display_message(text)
    build_text(175, 615, text, 20)
  end

  def freeze_game_for(seconds)
    @frozen_until = Time.now + seconds
  end

  def display_thumbnail_for(source)
    thumbnail_path = 
      case source
      when :character then @current_character_data[:image_path]
      when :self then game_characters[:player][:image_path]
      end
    
    screen.draw_dialogue_thumbnail(thumbnail_path)
  end

  def play_sound(path)
    GameSound.new(path).play
  end

  def play_sfx(key)
    GameSfx.new(key).play
  end



end