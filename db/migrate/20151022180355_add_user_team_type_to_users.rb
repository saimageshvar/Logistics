class AddUserTeamTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_type_team, :string
  end
end
