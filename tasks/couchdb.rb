require 'json'

role :couchdb do
  task :gems do
    sudo { exec! "apt-get install -y ruby-dev", echo: true }
    sudo { exec! "gem install couchrest -V", echo: true }
  end

  task :ping do
    curl "http://localhost:5984", echo: true
  end

  task :log do
    sudo { tail "-F", "/var/log/couchdb/couch.log", echo: true }
  end

  task :create_db do
    curl "-X", "PUT", "http://localhost:5984/test", echo: true
  end

  task :drop_db do
    curl "-X", "DELETE", "http://localhost:5984/test", echo: true
  end

  task :reset do
    couchdb.drop_db
    couchdb.create_db
  end

  task :replicate_once do
    (["lab1", "lab2", "lab3", "lab4", "lab5"] - [name]).each do |lab|
      payload = JSON.dump(source: "test", target: "http://#{lab}:5984/test")
      log("Replicating to: #{lab}")
      curl "-X", "POST", "http://localhost:5984/_replicate", "-d", payload, "-H", "Content-Type:application/json", echo: true
    end
  end

  task :replicate_cont do
    (["lab1", "lab2", "lab3", "lab4", "lab5"] - [name]).each do |lab|
      payload = JSON.dump(source: "test", target: "http://#{lab}:5984/test", continuous: true, connection_timeout: 1000, retries_per_request: 1)
      log("Enablig continous replication to: #{lab}")
      curl "-X", "POST", "http://localhost:5984/_replicate", "-d", payload, "-H", "Content-Type:application/json", echo: true
    end
  end
end
