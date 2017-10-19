require 'uba/command'

class CreateInventoryItem < Uba::Command
  define do
    {

      inventory_item_id: _String,
      name: _String
    }
  end
end

class DeactivateInventoryItem < Uba::Command
  define do
    {

      inventory_item_id: _String,
      original_version: _Integer
    }
  end
end

class RenameInventoryItem < Uba::Command
  define do
    {

      inventory_item_id: _String,
      new_name: _String,
      original_version: _Integer
    }
  end
end

class CheckInItemsToInventory < Uba::Command
  define do
    {

      inventory_item_id: _String,
      count: _Integer,
      original_version: _Integer
    }
  end
end

class RemoveItemsFromInventory < Uba::Command
  define do
    {

      inventory_item_id: _String,
      count: _Integer,
      original_version: _Integer
    }
  end
end
