namespace :core do

  desc "Tarefa agregada da aliementação das tabelas de cache"
  task process: :environment do
    puts Device.all.inspect
  end

  desc "Recebe a tabela arp dos switches e preenche a tabela arp da base de dados"
  task arp_table: :environment do

  end

  desc "Recebe a tabela MAC dos switches e preenche a tabela mac da base de dados"
  task mac_table: :environment do
  end

  desc "Recebe a tabela de portas dos switches e preenche a tabela da base de dados"
  task port_table: :environment do
  end

end
