require 'snmp'
class A

  def self.b

     # http://10.15.199.210:8080/imcrs/plat/res/device?ip=172.25.0.2


    #http://10.15.199.210:8080/imcrs/plat/res/device/52


    #http://10.15.199.210:8080/imcrs/plat/res/device/52/interface?total=true



    SNMP::Manager.open(:host => '172.25.0.1') do |manager|
      response = manager.get(["1.3.6.1.2.1.4.22.1.2"])

      response.each_varbind do |vb|
        puts "#{vb.name.to_s}  #{vb.value.to_s}  #{vb.value.asn1_type}"
      end
    end

    include SNMP

    ifTable_columns = ["ifIndex", "ifDescr", "IP-MIB::ipNetToMediaPhysAddress"]
    SNMP::Manager.open(:host => '172.25.0.1') do |manager|
      ifTable = ObjectId.new("1.3.6.1.2.1.4.22.1.2")
      next_oid = ifTable
      while next_oid.subtree_of?(ifTable)
        response = manager.get_next(next_oid)
        varbind = response.varbind_list.first
        next_oid = varbind.name
        a = ""
        varbind.value.each_byte { |b| a << Integer(b).to_s(16) + ':' }
        #puts a
      end
    end

    exit
  end

end