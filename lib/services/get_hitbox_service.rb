class GetHitboxService < GetResourceService

  representing_resource :hitbox

  def call
    resource_class.new(hitbox_settings)
  end

  private

  def hitbox_settings
    settings.empty? ? calculate_hitbox_settings : settings
  end

  def calculate_hitbox_settings
    image = @game_object.image

    {
      x1_position: image.x_position, 
      y1_position: image.y_position, 
      x2_position: image.x_position + image.width, 
      y2_position: image.y_position + image.height
    }
  end

end

