#TODO : documenter l'utilisation de dynamic_key
module GameObject
  class Base

    attr_reader :key
    attr_reader :dynamic_key

    def initialize(key, dynamic_key: nil)
      @key = key
      @dynamic_key = dynamic_key
    end

    def data
      @data ||= GetDataService.new(self, data_options).call
    end

    def image
      @image ||= GetImageService.new(self, image_options).call
    end

    def hitbox
      @hitbox ||= GetHitboxService.new(self, hitbox_options).call
    end

    def text
      @text ||= GetTextService.new(self, text_options).call
    end

    def sound
      @sound ||= GetSoundService.new(self, sound_options).call
    end

    def music
      @music ||= GetMusicService.new(self, music_options).call
    end

    %w(data image hitbox text sound music).each do |method_name|
      define_method("#{method_name}_options") { {} }
    end

  end
end
