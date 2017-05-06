# mass resize scenes

scenes_paths = Dir.glob("./data/images/scenes/**")

scenes_paths.each do |scene_path|
  system("convert #{scene_path} -resize 600x450 -colors 256 #{scene_path}")
end