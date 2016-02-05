class Interface < ActiveRecord::Base
  belongs_to :device
  belongs_to :interface_type

  has_many :origin_connections, foreign_key: 'interface0_id', class_name: 'Connection'
  has_many :end_connections, foreign_key: 'interface1_id', class_name: 'Connection'

  def connections
    origin_connections + end_connections
  end

  def self.available(interface_origin_id, device_id)
    interface_origin = interface_origin = Interface.find(interface_origin_id)
    self
      .where(:device_id => device_id)
      .where(:interface_type_id => interface_origin.interface_type_id)
      .where(Interface.arel_table[:id].not_eq(interface_origin.id))
      .where('id NOT IN (SELECT interface0_id FROM connections UNION ALL SELECT interface1_id FROM connections)') #sem relacoes
  end

end
