require 'couchrest'

lab1 = CouchRest.database!("http://lab1:5984/test")
lab2 = CouchRest.database!("http://lab2:5984/test")
lab3 = CouchRest.database!("http://lab3:5984/test")
lab4 = CouchRest.database!("http://lab4:5984/test")
lab5 = CouchRest.database!("http://lab5:5984/test")

writes = []
numbers = (1..2000)

puts "Writing numbers 0-2000"
numbers.each do |i|
  writes << lab1.save_doc("_id" => i.to_s, number: i)
  puts "#{i}/#{numbers.count} done."
end

puts "Done, #{writes.count} acknowledged. <ENTER> to continue"
gets

[lab2, lab3, lab4, lab5].zip(%w(lab2 lab3 lab4 lab5)).each do |client, name|
  puts "Fetching result from #{name}"
  stored = []
  numbers.each do |i|
    stored.push(client.get(i.to_s)) rescue nil

    print "."
    STDOUT.flush
  end

  puts ""
  puts "Got results. Got #{stored.count} writes back"
end
