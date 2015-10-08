class CreateTempReqs < ActiveRecord::Migration
  def change
    create_table :temp_reqs do |t|
      t.integer :team_id
    	  t.string :item_name
    	  t.integer :count
      t.timestamps
    end
  end
end
