class DeviceModel < ActiveRecord::Base
  belongs_to :device_brand
  belongs_to :device_type
end
