require 'couchrest'

lab1 = CouchRest.database("http://lab1:5984/test")
lab2 = CouchRest.database("http://lab2:5984/test")

conflict_view = <<-VIEW
function(doc) {
  if(doc._conflicts) {
    emit(doc._conflicts, null);
  }
}
VIEW

lab2.save_doc(
  "_id" => "_design/conflict",
  views: {
    detect: {
      map: conflict_view
    }
  }
)

puts "Saving id: 1, payload 'a' to lab1"
lab1.save_doc("_id" => "1", "payload" => "a")

puts "Press <ENTER> to update payload"
gets

puts "Updating id: 1 to payload 'b' to lab1"
doc = lab1.get("1")
doc["payload"] = "b"
lab1.save_doc(doc)

puts "Reading the payload from lab1 and updating it in lab2"
another_doc = lab1.get("1")
another_doc["payload"] = "c"
lab2.save_doc(another_doc)

puts "Press <ENTER> to query conflicts"
gets

puts lab2.view('conflict/detect')['rows'].inspect
