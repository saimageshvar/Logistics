class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :password
      t.integer :team_id
      t.string :user_type

      t.timestamps
    end
  end
end
