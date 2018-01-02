require "rubygems"
require "bundler/setup"
require "ruby2d"
require "fastimage"
require "ruby-audio"
require "byebug"
require "require_all"
require "awesome_print"
require 'deep_merge'
require "benchmark"
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

  if game.selected_menu_item
    path = case game.selected_menu_item.key
           when :go_to then  './data/images/assets/go_to.png'
           when :look_at then './data/images/assets/eye.png'
           when :talk_to then './data/images/assets/mouth.png'
           when :take then './data/images/assets/take.png'
           when :give then './data/images/assets/give.png'
           end

    @cursor.remove if @cursor
    @cursor = Image.new(
      x: get(:mouse_x) - 20, 
      y: get(:mouse_y) - 20, 
      path: path,
      color: 'red'
    )

    @cursor.width, @cursor.height = 30, 30
  end

  if Time.now >= game.frozen_until && game.current_sentences.any?
    game.update_scene
    game.update_sentences if game.current_sentences.any?
  end

end

on :mouse_down do |event|
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