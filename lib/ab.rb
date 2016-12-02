class Ab
  require 'rubygems'
  require 'net/ssh'

  @hostname = "sju-sw-core.trt15.jus.br"
  @username = "sif"
  @password = "m0Ns!ftrt"

  def self.connect

    Net::SSH.start(@hostname, @username, :password => @password, :timeout => 3000, :verbose => :debug) do |session|
      #yield session

      telnet = Net::SSH::Telnet.new(
        "Dump_log" => "/dev/stdout",
        "Session" => session,
        "Prompt" => "<sju-sw-core>",
        "Terminator" => "\r"
      )

      puts "connected"

      puts telnet.cmd("echo hello")

    end
  end

  def self.command(session, command)
    response = ''

    session.open_channel do |channel|
      channel.exec(command) do |channel, success|
        raise "could not execute command '#{command}'" unless success
        channel.on_data do |channel, data|
          if data.include?('- More -')
            channel.send_data ' '
          elsif data.is_a?(String)
            response << data
          end
        end
      end
    end

    session.loop

    response
  end


  #display interface GigabitEthernet brief

  #Interface            Link Speed   Duplex Type PVID Description
  #GE0/0/1              UP   1G(a)   F(a)   T    1
  #GE0/0/2              UP   1G(a)   F(a)   A    199  unanovadg_ETH1


  def self.c
    interfaces = []
    self.connect do |session|
      interfaces = self.get_ethernet_interfaces(session)

      interfaces.each do |interface|
        if interface[:type] != "T"
          mac = self.get_mac(session, interface[:mod], interface[:port])
        end
      end
    end


  end

  def self.get_mac(session, mod, port)
    channel = self.command(session, self.display_mac_command(mod, port)) do |line|
      puts line
    end
    'as'
  end

  def self.get_ethernet_interfaces(session)
    interfaces = []




    # result = self.command(session, self.ethernet_interfaces_command)
    #
    # puts result
    #
    # result = self.command(session, self.ethernet_interfaces_command)
    #
    # puts result

    exit

    # do |line|
    #   interface = self.extract_interface(line)
    #   interfaces << interface if interface != nil
    # end

    interfaces
  end


  def self.extract_interface(line)
    regex = /^(\n*)GE(?<Mod>[0-9]+)\/0\/(?<Port>[0-9]+)\s+(?<Link>UP|DOWN|ADM)\s*(?<Speed>\S+)\s+(?<Duplex>\S+)\s+(?<Type>T|A|H)\s+(?<PVID>\S+)(\s+(?<Description> \S+))?(\n*)$/m
    matches = line.match(regex)

    if matches != nil
      {mod: matches[:Mod], port: matches[:Port], link: matches[:Link], speed: matches[:Speed], dupĺex: matches[:Duplex],
        type: matches[:Type], pvid: matches[:PVID], description: matches[:Description]}
    else
      nil
    end
  end

  def self.ethernet_interfaces_command
    "display interface GigabitEthernet brief"
  end

  def self.display_mac_command(mod, port)
    "display mac-address interface GigabitEthernet #{mod}/0/#{port}"
  end


end