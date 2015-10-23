class AddItemAllotedToItems < ActiveRecord::Migration
  def change
    add_column :items, :item_alloted, :integer
  end
end
