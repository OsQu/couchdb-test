group 'master' do
  host 'lab1'
  host 'lab2'
  host 'lab3'
  host 'lab4'
  host 'lab5'

  each_host do
    user "vagrant"
    role :couchdb
  end
end

role :couchdb do
  task :ping do
    curl "http://localhost:5984", echo: true
  end

  task :iptables do
    sudo { iptables "--list", echo: true }
  end

  task :slow do
    sudo { exec! 'tc qdisc add dev eth1 root netem delay 100ms 20ms distribution normal' }
  end

  task :drop do
    sudo { exec! 'tc qdisc add dev eth1 root netem loss 50% 25%' }
  end

  task :heal_network do
    sudo { exec! 'tc qdisc del dev eth1 root' }
  end
end
