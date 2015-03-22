boxes = [
  { name: "lab1", ip: "10.0.0.1" },
  { name: "lab2", ip: "10.0.0.2" },
  { name: "lab3", ip: "10.0.0.3" },
  { name: "lab4", ip: "10.0.0.4" },
  { name: "lab5", ip: "10.0.0.5" }
]

hosts = boxes.map {|b| "#{b[:ip]}\t#{b[:name]}"}
local = ["127.0.0.1\tlocalhost"]

hosts_str = (local + hosts).join("\n")


Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  boxes.each do |box|
    config.vm.define box[:name] do |box_config|
      box_config.vm.network "private_network", ip: box[:ip]
      box_config.vm.provision "shell", inline: "echo '#{hosts_str}' > /etc/hosts"
    end
  end

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "512"
  end
end
