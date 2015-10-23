class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :team_id
      t.integer :item_id
      t.integer :requested
      t.integer :approved
      t.integer :allotted
      t.timestamps
    end
  end
end
