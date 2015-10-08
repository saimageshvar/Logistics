class Log < ActiveRecord::Base

  belongs_to :item
  belongs_to :team
  belongs_to :request

end
