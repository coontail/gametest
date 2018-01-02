class GameObject::Inventory
  
  def initialize
    @item_keys = []
  end

  def items
    @item_keys.map.with_index(1) do |key, i|
      if position = position_for(i)
        GameObject::InventoryItem.new(key, dynamic_key: position)
      end
    end.compact
  end

  def add(item_key)
    @item_keys << item_key unless @item_keys.include?(item_key)
  end

  def remove(item_key)
    @item_keys -= [item_key]
  end

  private

  def position_for(i)
    "item_#{i}".to_sym if (1..4).include?(i)
  end

end