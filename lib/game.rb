class Game

  attr_accessor :frozen_until
  attr_accessor :mouse_x
  attr_accessor :mouse_y

  attr_reader :current_scene
  attr_reader :current_scene_data
  attr_reader :current_music
  attr_reader :current_character
  attr_reader :current_character_data
  attr_reader :current_character_coordinates
  attr_reader :current_sound
  attr_reader :current_action

  def initialize
    @current_scene = :scene1
    @frozen_until = Time.now
    @current_action = :go_to

    update_scene
  end

  def update_scene
    @current_scene_data = game_map[@current_scene]

    update_music
    update_image
    update_menu
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

    # current_scene_data[:events].keys.each do |area|
    # coordinates = area.is_a?(Symbol) ? area_to_coordinates(area) : area
    #   Rectangle.new(*coordinates.flatten, "red")
    # end

    update_characters
    update_background
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
    get_menu_event || get_map_event || get_character_event
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

  def update_description(object)
    description_data = game_descriptions[object]

    if description_data
      display_message(description_data[:text])
      play_sound(description_data[:sound_path])
    end
  end

  def update_dialogues
    dialogue_data = game_dialogues[@current_character]

    if dialogue_data
      display_character_thumbnail
      display_message(dialogue_data[:default])

      if dialogue_data[:default_sound_path]
        play_sound(dialogue_data[:default_sound_path])
      end
    
      display_choices(dialogue_data[:choices])
    
    else
      play_sound(game_sfx[:cough])
    end
  end

  def display_character_thumbnail
    sprite = Image.new(16, 600, @current_character_data[:image_path])
    sprite.width = 130
    sprite.height = 150
  end

  def display_message(text)
    build_text(175, 615, text, 20)
  end

  def display_choices(choices)
    choices_coordinates = [[175, 665], [175, 690], [175, 715]]
    
    choices.each_with_index do |(choice_key, choice_data), index|
      build_text(*choices_coordinates[index], choice_data[:text], 17)
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

    sound_duration = TagLib::FileRef.open(@current_sound.path){ |fileref| fileref.audio_properties.length }
    freeze_game_for(sound_duration)
  end

  # def set_highlight
  #   current_menu = game_menus.values.find{ |menu_data| menu_data[:action] == @current_action }[:cursor_path]
  # end

  # def x
  #   {
  #     merchant: {
  #       default: "Salut l'étranger, que fais-tu ici ?",
  #       choices: {
  #         choice_1: {
  #           text: "Je ne sais pas trop, pour être honnête...",

  #           sentences: [
  #             {
  #               text: "J'ai plein de marchandises à te proposer !",
  #               sound: "./data/dialogues/dial_2.ogg"
  #             },

  #             {
  #               text: "Ah oui ? Quel type de marchandises ?",
  #               source: "self"
  #             },

  #             {
  #               text: "Petit curieux va, ça ne te regarde pas"
  #             },

  #             { 
  #               text: "Allez, file, du balai !"
  #             },

  #             {
  #               text: "Pas très aimable...",
  #               source: "self"
  #             }
  #           ]
  #         },

  #         choice_2: {
  #           text: "En quoi ça vous regarde ?",

  #           sentences: [
  #             {
  #               text: "Tout doux mec, je veux pas d'ennuis moi",
  #               source: "character"
  #             }
  #           ]
  #         },

  #         choice_3: {
  #           text: "Au revoir",

  #           sentences: [
  #             {
  #               text: "Salut l'ami !",
  #               source: "character"
  #             }
  #           ]
  #         }
  #       }

  #     }
  #   }
  # end

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