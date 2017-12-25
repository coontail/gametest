module GameSound
  class Base

    def initialize(settings={})
      @sound_path = settings[:sound_path]
    end

    def play
      current_sound.play
    end

    def duration
      @duration ||= TagLib::FileRef.open(@sound_path){ |fileref| fileref.audio_properties.length } * 1.5
    end

    private

    def current_sound
      Sound.new(@sound_path)
    end

  end
end