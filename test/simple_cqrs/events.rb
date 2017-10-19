require 'uba/event'

class InventoryItemCreated < Uba::Event
  define do
    {
      id: _String,
      name: _String
    }
  end
end

class InventoryItemDeactivated < Uba::Event
  define do
    { id: _String }
  end
end

class InventoryItemRenamed < Uba::Event
  define do
    {
      id: _String,
      new_name: _String
    }
  end
end

class ItemsCheckedInToInventory < Uba::Event
  define do
    {
      id: _String,
      count: _Integer
    }
  end
end

class ItemsRemovedFromInventory < Uba::Event
  define do
    {
      id: _String,
      count: _Integer
    }
  end
end
