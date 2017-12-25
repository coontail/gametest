module GameSettings
  class GameDescriptionSettings

    def self.menu_items
      {
        go_to: {
          body: 'Aller vers',
          x_position: 860,
          y_position: 630
        },

        look_at: {
          body: 'Regarder',
          x_position: 820,
          y_position: 670
        },
        
        talk_to: {
          body: 'Parler à',
          x_position: 930,
          y_position: 670
        },

        take: {
          body: 'Prendre',
          x_position: 820,
          y_position: 710
        },

        give: {
          body: 'Donner',
          x_position: 930,
          y_position: 710
        }
      }
    end

  end
end