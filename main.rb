require "rubygems"
require "bundler/setup"
require "ruby2d"
require "fastimage"
require "taglib"
require "byebug"

require "./lib/game.rb"
require "./lib/gameplay.rb"

set title: "Jeu de test"
set width: 1024, height: 768

game = Game.new

update do

  # path = "./data/images/sprites/up_arrow.png"
  # @cursor.remove if @cursor
  # x = get(:mouse_x)
  # y = get(:mouse_y)
  # @cursor = Image.new(x, y, path)

  if Time.now >= game.frozen_until && game.current_sentences.any?
    game.update_scene
    game.update_sentences
  end

  # puts "#{game.current_sentences} #{game.current_character} #{game.current_dialogue} #{game.current_dialogue_data}"

  on mouse: 'any' do |mouse_x, mouse_y|
    if Time.now >= game.frozen_until

      clear # Clear stacked assets
      game.update_scene # Refresh assets

      game.mouse_x = mouse_x
      game.mouse_y = mouse_y

      event = game.get_event

      if event
        game.apply_event(event)
      end

    end
  end

end

show