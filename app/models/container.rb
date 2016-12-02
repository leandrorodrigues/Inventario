class Container < ActiveRecord::Base
  belongs_to :place
  belongs_to :item
  belongs_to :container_type
  has_many :container_slots

  validates :title, presence: true
  validates_associated :item

  def self.build_complete(container_params, item_params)
    @container = Container.new(container_params)
    #container_type = ContainerType.find container_params[:container_type_id]


    #@item = Item.new(item_params)
    #@item.title = "Container Number #{@item.number}"

    @item = Item.find_by_number(item_params[:number])
    if !@item
      @item = Item.new
      @item.errors.add(:number, 'Item not found')
    end

    @container.item = @item

    #cria as relacoes dos slots
    (1..@container.container_type.slots).each do |i|
      @container.container_slots << ContainerSlot.new(:title => "#{i}U")
    end

    @container
  end
end
