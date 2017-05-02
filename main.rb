require "ruby2d"
require "fastimage"
require "./lib/game.rb"
require "./lib/gameplay.rb"

set title: "Jeu de test"
set width: 1024, height: 768

game = Game.new

update do

  on mouse: 'any' do |mouse_x, mouse_y|
    game.mouse_x = mouse_x
    game.mouse_y = mouse_y

    event = game.get_event

    if event
      game.apply_event(event)
    end
  end

end

show