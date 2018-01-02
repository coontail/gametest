module GameMusic
  class Base

    attr_reader :path

    def initialize(settings={})
      @path = settings[:music_path]
    end

    def play
      music.tap do |m|
        m.loop = true
        m.play
      end
    end

    def is_similar_to?(object)
      object && object.path == self.path
    end

    private

    def music
      @music ||= Music.new(@path)
    end

  end
end