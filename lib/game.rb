class Game

  attr_accessor :mouse_x
  attr_accessor :mouse_y
  attr_accessor :frozen_until
  attr_accessor :current_sentences

  attr_reader :current_scene
  attr_reader :current_scene_data
  attr_reader :current_music
  attr_reader :current_character
  attr_reader :current_character_data
  attr_reader :current_character_coordinates
  attr_reader :current_sound
  attr_reader :current_action
  attr_reader :current_dialogue
  attr_reader :current_dialogue_data

  def initialize
    @current_scene = :scene4
    @frozen_until = Time.now
    @current_action = :go_to
    @current_sentences = []

    update_scene
  end

  def update_scene
    @current_scene_data = game_map[@current_scene]

    update_music
    update_image
    update_characters
    update_background
    update_menu
  end

  def update_sentences
    sentence_data = @current_sentences[0]

    display_thumbnail_for(sentence_data[:source])
    display_message(sentence_data[:text])
    play_sound(sentence_data[:sound_path])

    @current_sentences.shift
  end

  def update_music
    new_music = game_map[@current_scene][:music] || :main

    if @current_music != new_music
      @current_music = new_music

      game_music[@current_music].loop = true
      game_music[@current_music].play
    end
  end

  def update_image    
    img = Image.new(0, 0, @current_scene_data[:image_path])
    img.width = 800
    img.height = 600
  end

  def update_characters
    if @current_scene_data[:character]
      @current_character = @current_scene_data[:character]
      @current_character_data = game_characters[@current_character]

      x1 = 200
      y1 = 150

      sprite = Image.new(x1, y1, @current_character_data[:image_path])
      sprite.width = 300
      sprite.height = 450

      @current_character_coordinates = [[x1, y1], [x1 + sprite.width, y1 + sprite.height]]     
    else
      @current_character = nil
      @current_character_data = nil
      @current_character_coordinates = nil
    end
  end
  
  def update_background
    Image.new(0,0, "./data/images/background.png")
  end

  def update_menu
    game_menus.each do |k,v|
      color = (@current_action == v[:action] ? "black" : "white")
      build_text(*k.first, v[:text], 22, color)
    end
  end

  def get_event
    get_menu_event || 
    get_choice_event ||
    get_map_event || 
    get_character_event
  end

  def get_map_event
    map_events = @current_scene_data[:events]
    
    map_event = map_events.find do |area, event|
      coordinates = area.is_a?(Symbol) ? area_to_coordinates(area) : area
      is_in_rectangle?(*coordinates.flatten, @mouse_x, @mouse_y)
    end

    if map_event
      { type: :direction }.merge(map_event.last)
    end
  end

  def get_menu_event
    menu_event = game_menus.find do |coordinates, data|
      is_in_rectangle?(*coordinates.flatten, @mouse_x, @mouse_y)
    end    

    if menu_event
      { type: :menu }.merge(menu_event.last)
    end
  end

  def get_choice_event
    choice_event = choices_coordinates.find do |coordinates, choice|
      is_in_rectangle?(*coordinates.flatten, @mouse_x, @mouse_y)
    end    

    if choice_event
      { type: :choice }.merge(choice_event.last)
    end
  end

  def get_character_event
    if @current_character && is_in_rectangle?(*@current_character_coordinates.flatten, @mouse_x, @mouse_y)
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
      play_sound(game_sfx[:clicking])

    when [:character, :talk_to]
      update_dialogues
    
    when [:character, :look_at]
      update_description(@current_character)
    end
  end

  def apply_choice(choice)
    choice_data = @current_dialogue_data[:choices][choice]

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

  def update_dialogues
    if @current_character
      @current_dialogue = @current_character
      @current_dialogue_data = game_dialogues[@current_dialogue]

      if @current_dialogue_data
        display_thumbnail_for(:character)
        display_message(@current_dialogue_data[:default])

        if @current_dialogue_data[:default_sound_path]
          play_sound(@current_dialogue_data[:default_sound_path])
        end
      
        display_choices(@current_dialogue_data[:choices])
      
      else
        play_sound(game_sfx[:cough])
      end
    end
  end

  def display_thumbnail_for(source)
    thumbnail = 
      case source
      when :character then @current_character_data[:image_path]
      when :self then game_characters[:player][:image_path]
      end
    
    sprite = Image.new(16, 600, thumbnail)
    sprite.width = 130
    sprite.height = 150
  end

  def display_message(text)
    build_text(175, 615, text, 20)
  end

  def display_choices(choices)
    choices.each_with_index do |(choice_key, choice_data), index|
      build_text(*choices_coordinates.keys[index][0], choice_data[:choice_text], 17)
    end
  end

  def build_text(x, y, text, size, color="white")
    Text.new(x, y, text, size, "./data/fonts/andersans.ttf", color)
  end

  def freeze_game_for(seconds)
    @frozen_until = Time.now + seconds
  end

  def play_sound(sound)
    new_sound = sound.is_a?(Sound) ? sound : Sound.new(sound)

    # @current_sound.stop unless @current_sound.nil?

    @current_sound = new_sound
    @current_sound.play

    sound_duration = TagLib::FileRef.open(@current_sound.path){ |fileref| fileref.audio_properties.length } * 1.5
    freeze_game_for(sound_duration)
  end

  def area_to_coordinates(area)
    case area
    when :left then [[0, 0], [80, 600]]
    when :right then [[720, 0], [800, 600]]
    end
  end

  def is_in_rectangle?(x1, y1, x2, y2, xp, yp)
    xp >= x1 &&
    xp <= x2 &&
    yp >= y1 &&
    yp <= y2 
  end

  def choices_coordinates
    @choices_coordinates ||= Gameplay.choices
  end

  def game_descriptions
    @game_descriptions ||= Gameplay.descriptions
  end

  def game_menus
    @game_menu ||= Gameplay.menus
  end

  def game_dialogues
    @game_dialogues ||= Gameplay.dialogues
  end

  def game_characters
    @game_characters ||= Gameplay.characters
  end

  def game_map
    @game_map ||= Gameplay.map
  end

  def game_sfx
    @game_sfx ||= Gameplay.sfx
  end

  def game_music
    @game_music ||= Gameplay.musics
  end

end