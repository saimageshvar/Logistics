class User < ActiveRecord::Base

  validates :user_name, :presence => true
  validates :team_id, :presence => true
  validates :team_id, :presence => true

end
