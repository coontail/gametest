class GetSoundDurationService

  def initialize(sound_path)
    @sound_path = sound_path
  end

  def call
    calculate_duration
  end

  private

  def calculate_duration
    sound_info.frames.to_f / sound_info.samplerate.to_f
  end
    
  def sound_info
    @sound_info ||= RubyAudio::Sound.open(@sound_path).info
  end

end
