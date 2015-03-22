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
end
