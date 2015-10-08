class Request < ActiveRecord::Base

  belongs_to :item
  belongs_to :team
  has_many :logs

end
