class GameSound::Sfx < GameSound::Base

  def initialize(key)
    @sound_path = game_sfxs[key][:sound_path]
  end
  
  private

  # À bouger....
  def game_sfxs
    @game_sfxs ||= $settings[:game_settings][:data][:sfx]
  end

end