class Connection < ActiveRecord::Base
  belongs_to :origin_interface, foreign_key: 'interface0_id', class_name: 'Interface'
  belongs_to :end_interface, foreign_key: 'interface1_id', class_name: 'Interface'

  validates :interface0_id, presence: true
  validates :interface1_id, presence: true
end
