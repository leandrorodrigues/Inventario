class Device < ActiveRecord::Base
  belongs_to :device_model
  belongs_to :item
  has_many :interfaces
  has_many :container_slots, autosave: true

  validates :title, presence: true
  validates_associated :item

  def self.search(params)
    results = all

    if !params[:q].blank?
      results = results.where "devices.title LIKE ?", "%#{params[:q]}%"
    end

    if !params[:container_id].blank?
      results = results.includes(:container_slots).where(container_slots: {container_id: params[:container_id]})
    end

    if !params[:device_type_id].blank?
      results = results.includes(:device_model).where(device_models: {device_type_id: params[:device_type_id]})
    end

    results
  end

  #cria um dispositivo completo gerando as interfaces
  def self.build_complete(device_params, item_params, slot_params)
    @device = Device.new(device_params)

    #cria item relacionado
    #@item = Item.new(item_params)
    #@item.title = "Device Number #{@item.number}"

    @item = Item.find_by_number(item_params[:number])
    if !@item
      @item = Item.new
      @item.errors.add(:number, 'Item not found')
    end

    @device.item = @item


    # cria a alocação deste dispositivo no rack(container)
    picked_slots = ContainerSlot.find_picked_slots slot_params['container_id'],
                                                   slot_params['container_slot_id'],
                                                   @device.device_model.rack_units

    @device.container_slots = picked_slots

    #cria as interfaces ethernet deste dispositivo
    if @device.device_model.ethernet_interfaces
      (1..@device.device_model.ethernet_interfaces).each  do |i|
        @device.interfaces <<  Interface.new(:title => 'Ethernet Port ' + i.to_s, :interface_type_id => ETHERNET_INTERFACE)
      end
    end

    if @device.device_model.fiber_interfaces
      (1..@device.device_model.fiber_interfaces).each  do |i|
        @device.interfaces <<  Interface.new(:title => 'Fiber Port ' + i.to_s, :interface_type_id => FIBER_INTERFACE)
      end
    end

    @device
  end

end
