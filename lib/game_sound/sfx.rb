class GameSound::Sfx < GameSound::Base

  def initialize(key)
    @sound_path = game_sfxs[key][:sound_path]
  end
  
  private

  def game_sfxs
    @game_sfxs ||= Gameplay.sfx
  end

end