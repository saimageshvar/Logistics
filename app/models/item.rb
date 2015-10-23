class Item < ActiveRecord::Base
  has_many :requests
   auto_strip_attributes :item_name , :strip_html => true
end
