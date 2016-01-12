class Device < ActiveRecord::Base
  belongs_to :device_model
  belongs_to :item
  has_many :interfaces

  validates :title, presence: true
  validates_associated :item

  #cria um dispositivo completo gerando as interfaces
  def self.build_complete(device_params, item_params, slot_params)
    @device = Device.new(device_params)

    #cria item relacionado
    @item = Item.new(item_params)
    @item.title = "Device Number #{@item.number}"

    @device.item = @item


    # cria a alocação deste dispositivo no rack(container)
    picked_slots = ContainerSlot.find_picked_slots slot_params['container_id'],
                                                   slot_params['container_slot_id'],
                                                   @device.device_model.rack_units

    @device.item.container_slots = picked_slots

    #cria as interfaces ethernet deste dispositivo
    (1..@device.device_model.ethernet_interfaces).each  do |i|
      @device.interfaces <<  Interface.new(:title => 'Ethernet Port ' + i.to_s, :interface_type_id => ETHERNET_INTERFACE)
    end

    @device
  end

end
