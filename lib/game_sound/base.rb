module GameSound
  class Base

    def initialize(path)
      @sound_path = path
    end

    def play
      current_sound.play
    end

    private

    def current_sound
      Sound.new(@sound_path)
    end

    # à foutre dans un Module a part 
    # def freeze
    #   TagLib::FileRef.open(@current_sound_path){ |fileref| fileref.audio_properties.length } * 1.5
    #   freeze_game_for(sound_duration)
    #end

  end
end