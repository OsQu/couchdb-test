role :couchdb do
  task :ping do
    curl "http://localhost:5984", echo: true
  end

  task :log do
    sudo { tail "-f", "/var/log/couchdb/couch.log", echo: true }
  end
end
