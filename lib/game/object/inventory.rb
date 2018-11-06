class Game::Object::Inventory

  attr_reader :items

  def initialize
    @item_keys = []
    @items = []
  end

  def add(item_key)
    unless @item_keys.include?(item_key)
      @item_keys << item_key
      update_items
    end
  end

  def remove(item_key)
    @item_keys -= [item_key]
    update_items
  end

  private

  def update_items
    inventory_items = @item_keys.map.with_index(1) do |key, i|
      if position = position_for(i)
        Game::Object::InventoryItem.new(key, dynamic_key: position)
      end
    end

    @items = inventory_items.compact
  end

  def position_for(i)
    "item_#{i}".to_sym if (1..4).include?(i)
  end

end
