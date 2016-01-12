class Interface < ActiveRecord::Base
  belongs_to :device
  belongs_to :interface_type
end
