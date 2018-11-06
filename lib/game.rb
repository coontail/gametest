class Game

  attr_accessor :mouse_x, :mouse_y, :frozen_until

  attr_reader :current_sentences
  attr_reader :current_scene
  attr_reader :current_choices
  attr_reader :inventory
  attr_reader :selected_menu_item

  def initialize(options={})
    @frozen_until = Time.now

    init_gameplay_variables
    init_menu_items
    init_inventory

    update_scene
  end

  def init_gameplay_variables
    @current_character = nil
    @current_choices = []
    @current_sentences = []
    @current_scene = Game::Object::Scene.new(:scene_1)

    @available_directions = []
  end

  def init_inventory
    @inventory = Game::Object::Inventory.new

    default_item_keys = [:audio_cassette]
    default_item_keys.each { |item_key| @inventory.add item_key }
  end

  def init_menu_items
    @current_menu_items = [:go_to, :look_at, :talk_to, :take, :give].map do |key|
      Game::Object::MenuItem.new(key)
    end

    @selected_menu_item = @current_menu_items.find { |i| i.key == :go_to }
  end

  def update_scene
    update_music
    update_scene_image
    update_characters
    draw_direction_arrows
    update_overlay
    update_menu_items
    update_inventory_items

    # x = {
    #   update_music: bench(update_music),
    #   update_scene_image: bench(update_scene_image),
    #   update_characters: bench(update_characters),
    #   draw_direction_arrows: bench(draw_direction_arrows),
    #   update_overlay: bench(update_overlay),
    #   update_menu_items: bench(update_menu_items),
    #   update_inventory_items: bench(update_inventory_items),
    # }

    # ap x
  end

  def bench(x)
    Benchmark.measure{ x }.real
  end

  def update_music
    unless @current_scene.music.is_similar_to? @background_music
      @background_music = @current_scene.music
      @background_music.play
    end
  end

  def update_scene_image
    @current_scene.image.draw
  end

  def update_characters
    @current_character = @current_scene.character
    @current_character.image.draw if @current_character
  end

  def update_overlay
    @current_scene.overlay.image.draw
  end

  def update_menu_items
    @current_menu_items.each do |menu_item|
      item_color = (menu_item == @selected_menu_item) ? 'black' : 'white'

      menu_item.text.color = item_color
      menu_item.text.write
    end
  end

  def update_inventory_items
    @inventory.items.each { |inventory_item| inventory_item.image.draw }
  end

  def draw_direction_arrows
    @available_directions = @current_scene.events.keys.map do |key|
      Game::Object::Direction.new(key)
    end

    @available_directions.each { |direction| direction.image.draw }
  end

  def get_event
    # x = {
    #   get_inventory_event: bench(get_inventory_event),
    #   get_menu_event: bench(get_menu_event),
    #   get_choice_event: bench(get_choice_event),
    #   get_map_event: bench(get_map_event),
    #   get_character_event: bench(get_character_event)
    # }

    # ap x

    get_inventory_event ||
    get_menu_event ||
    get_choice_event ||
    get_map_event ||
    get_character_event
  end

  def get_map_event
    concerned_directions = @available_directions.select do |direction|
      @current_scene.events.keys.include?(direction.key)
    end

    touched_direction = concerned_directions.find do |direction|
      direction.hitbox.is_touched_by?(@mouse_x, @mouse_y)
    end

    if touched_direction
      { type: :direction, object: touched_direction }
    end
  end

  def get_menu_event
    touched_menu_item = @current_menu_items.find do |menu_item|
      menu_item.hitbox.is_touched_by?(@mouse_x, @mouse_y)
    end

    if touched_menu_item
      { type: :menu, object: touched_menu_item }
    end
  end

  def get_inventory_event
    touched_inventory_item = @inventory.items.find do |inventory_item|
      inventory_item.hitbox.is_touched_by?(@mouse_x, @mouse_y)
    end

    if touched_inventory_item
      { type: :inventory, object: touched_inventory_item }
    end
  end

  def get_choice_event
    if @current_choices
      touched_choice = @current_choices.find do |choice|
        choice.hitbox.is_touched_by?(@mouse_x, @mouse_y)
      end

      if touched_choice
        { type: :choice, object: touched_choice }
      end
    end
  end

  def get_character_event
    if @current_character && @current_character.hitbox.is_touched_by?(@mouse_x, @mouse_y)
      { type: :character, object: @current_character }
    end
  end

  def apply_event(event)

    if event[:type] == :menu
      @selected_menu_item = event[:object]
    end

    if event[:type] == :choice
      @current_choices = nil
      @current_sentences = event[:object].sentences
    end

    case [event[:type], @selected_menu_item.key]

    when [:direction, :go_to]
      direction = event[:object]
      next_scene = @current_scene.next_scene_for(direction.key)

      if next_scene
        @current_scene = next_scene
        update_scene
        play_sfx(:clicking)
      end


    when [:character, :talk_to]
      update_dialogues

    when [:inventory, :look_at]
      @current_sentences = event[:object].description.sentences
    when [:character, :look_at]
      @current_sentences = event[:object].description.sentences
    end
  end

  ## Update sentences est géré par le main because gestion du timing etc etc
  ## Renommer classe et sentences par dialogue_sentences pour éviter la confusion?
  def update_sentences
    @current_sentences[0].tap do |sentence|
      sentence.image.draw
      sentence.text.write
      sentence.sound.play
      freeze_game_for(sentence.sound.duration)

      if sentence.given_item
        @inventory.add sentence.given_item
      end

      if sentence.choices.any?
        @current_sentences = []
        @current_choices = sentence.choices
        @current_choices.each { |choice| choice.text.write }
      else
        @current_sentences.shift
      end
    end

  end

  def update_dialogues
    if @current_character
      @current_sentences = @current_character.dialogue.sentences
      play_sfx(:cough) unless @current_sentences.any?
    end
  end

  def freeze_game_for(seconds)
    @frozen_until = Time.now + seconds
  end

  def play_sfx(key)
    sfx = Game::Sound::Sfx.new(key)
    sfx.play && freeze_game_for(sfx.duration)
  end

end
