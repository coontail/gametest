class GameSfx < GameSound

  def initialize(key)
    @sound_path = game_sfxs[key]
  end
  
  private

  def game_sfxs
    @game_sfxs ||= Gameplay.game_sfx
  end

end