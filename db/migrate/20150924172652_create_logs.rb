class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :request_id
      t.integer :item_id
      t.integer :team_id
      t.integer :approved
      t.integer :requested
      t.string :status

      t.timestamps
    end
  end
end
