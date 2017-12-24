module GameMusic
  class Base
    
    DEFAULT_MUSIC_KEY = :main.freeze

    def initialize(key=DEFAULT_MUSIC_KEY)
      @current_music_key = key
    end

    def update(key)
      music_changed = (@current_music_key != key)

      @current_music_key = (key || DEFAULT_MUSIC_KEY)

      play_music if music_changed
    end

    private

    def game_musics
      @game_musics ||= Gameplay.musics
    end

    def current_music
      Music.new(game_musics[@current_music_key])
    end

    def play_music
      current_music.loop = true
      current_music.play
    end

  end
end