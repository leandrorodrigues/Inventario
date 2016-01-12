class Item < ActiveRecord::Base
  has_many :container_slots
  validates :title, presence: true
  validates :number, presence: true, uniqueness: { message: 'This number exists in database. Insert another number.'}

  has_one :device
  has_one :container
end
