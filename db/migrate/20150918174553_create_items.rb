class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item_name
      t.integer :item_total
      t.integer :item_requested
      t.integer :item_approved
      t.integer :item_remaining

      t.timestamps
    end
  end

end
