require 'yaml'
require 'fileutils'

def yamlize(klass, ressource_name)
  m = klass.public_methods(false).reject{|x| [:yaml_tag, :new, :allocate, :superclass].include? x}

  root_dir_path = "./lib/game_settings/#{ressource_name}/"
  FileUtils.mkdir_p root_dir_path unless Dir.exists? root_dir_path

  m.each do |_m|
    m_file_path = File.join(root_dir_path, "#{_m.to_s}.yml")

    return if File.exists? m_file_path

    hash_content = klass.send(_m)

    full_hash = {
      game_settings: {
        ressource_name.to_sym => {
          _m => hash_content
        }
      }
    }

    yaml = full_hash.to_yaml

    f = File.open(m_file_path, 'w')
    f.write(yaml)
    f.close
  end
end