class ContainerSlot < ActiveRecord::Base
  belongs_to :container
  belongs_to :item


  #retorna os slots disponíveis de acordo com o container e o número de slots demandados
  #exemplo: preciso de 3 slots seguidos vagos no container Rack A
  def self.available_slots(container_id, number_slots)

    number_slots = 1 if number_slots == 0

    @available = []

    slots = self
                .where(:container_id => container_id)
                .includes(:item)

    if slots.count < number_slots
      return []
    end

    slots.each.with_index do |slot, index|
      #testa se os enésimos slots estão disponíveis
      @next_available = true
      (0..(number_slots - 1)).each do |n|
        if slots[index + n] == nil || #no caso de não existir próximos disponiveos
           slots[index + n].item != nil #slot ocupado
          @next_available = false
          break
        end
      end

      next if !@next_available

      @available << slot
    end

    @available
  end

  #retorna os slots selecionados a partir de um determinado slot
  #exemplo: selecionei quatro slots a partir do slot U12 do RACK A
  def self.find_picked_slots(container_id, container_slot_id, number_slots)
    self.where(:container_id => container_id).where('id >= ?', container_slot_id).take(number_slots)
  end

end
