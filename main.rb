require "rubygems"
require "bundler/setup"
require "ruby2d"
require "fastimage"
require "taglib"
require "byebug"
require "require_all"
require "awesome_print"
require 'deep_merge'
require "yaml"

require_all "./lib/**/*.rb"

# Screen sizes cheatsheet
# 840x630 = cool
# 1280x960 = cool

set title: "Jeu de test"
set width: 1280, height: 960

$screen = Screen.new(
  width: get(:width),
  height: get(:height)
)

$settings = {}

Dir.glob("./**/**.yml").each do |setting_file_path|
  setting_file = File.read(setting_file_path)
  $settings.deep_merge! YAML.load(setting_file)
end

game = Game.new

update do

  # path = "./data/images/sprites/up_arrow.png"
  # @cursor.remove if @cursor
  # x = get(:mouse_x)
  # y = get(:mouse_y)
  # @cursor = game.draw_image(x, y, path)

  if Time.now >= game.frozen_until && (game.current_sentences.any? || game.current_description)
    game.update_scene
    game.update_sentences if game.current_sentences.any?
    game.update_description if game.current_description
  end

end

on :mouse_down do |event|
  puts "MOUSE DOWN"
  if Time.now >= game.frozen_until

    game.mouse_x = event.x
    game.mouse_y = event.y

    if (event = game.get_event)
      clear # Clear stacked assets
      game.apply_event(event) # Apply event
      game.update_scene # Refresh assets
    end

  end
end

show