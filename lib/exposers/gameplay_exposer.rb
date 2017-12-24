module Exposers
  class GameplayExposer

  def music
    @music ||= GameMusic.new
  end

  def menus

  end

  end
end