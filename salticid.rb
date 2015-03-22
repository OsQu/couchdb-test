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

  task :log do
    sudo { tail "-f", "/var/log/couchdb/couch.log", echo: true }
  end

  task :slow do
    log("Slowing down network 100ms 20ms")
    sudo { exec! 'tc qdisc add dev eth1 root netem delay 100ms 20ms distribution normal' }
  end

  task :drop do
    log("Dropping packets 50% 25%")
    sudo { exec! 'tc qdisc add dev eth1 root netem loss 50% 25%' }
  end

  task :heal_network do
    log("Healing network")
    sudo { exec! 'tc qdisc del dev eth1 root' }
  end

  task :partition do
    if ["lab1", "lab2"].include?(name)
      log("Partitioning from lab3 lab4 lab5")
      sudo do
        exec! "iptables -A INPUT -s lab3 -j DROP"
        exec! "iptables -A INPUT -s lab4 -j DROP"
        exec! "iptables -A INPUT -s lab5 -j DROP"
      end
    else
      log("Partitioning from lab1 lab2")
      sudo do
        exec! "iptables -A INPUT -s lab1 -j DROP"
        exec! "iptables -A INPUT -s lab2 -j DROP"
      end
    end

    sudo { iptables "--list", echo: true }
  end

  task :heal_partition do
    sudo do
      iptables "-F", echo: true
      iptables "-X", echo: true
      iptables "--list", echo: true
    end
  end
end
