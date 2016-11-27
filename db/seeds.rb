d1 = Driver.create!({name: 'ManuAc', email: 'manu@gmail.com', mobile: '9988776655', adress: 'bangalore'})
d2 = Driver.create!({name: 'RahulR', email: 'rahul@gmail.com', mobile: '9988776655', adress: 'bangalore'})
d3 = Driver.create!({name: 'Akash', email: 'akash@gmail.com', mobile: '9988776655', adress: 'bangalore'})
d4 = Driver.create!({name: 'Sachin', email: 'sachin@gmail.com', mobile: '9988776655', adress: 'bangalore'})

c1 = Cab.create!({name: 'Bmw', model: 'X1', number: 'KA-06-AC-3456', ctype: 'black', city: 'bangalore', driver_id: d1.id, active: true, available: true})
c2 = Cab.create!({name: 'Audi', model: 'A6', number: 'KA-04-AC-3476', ctype: 'pink', city: 'bangalore', driver_id: d2.id, active: true, available: true})
c3 = Cab.create!({name: 'Merc', model: 'F1', number: 'KA-06-AC-2467', ctype: 'black', city: 'bangalore', driver_id: d3.id, active: true, available: true})
c4 = Cab.create!({name: 'Bmw', model: 'F1', number: 'KA-05-AC-1567', ctype: 'pink', city: 'bangalore', driver_id: d4.id, active: true, available: true})

[["12.956259012", "77.653463077"], ["12.956334542", "77.654563051"], ["12.956452012", "77.655633077"], ["12.956352052", "77.654643077"]].each_with_index do |location, i|
  loc = Location.create!({latitude: location[0], longitude: location[1]})
  cab = eval("c#{i}")
  cab.current_location = loc
  cab.save
end

user = User.create!({name: 'Sanjana', email: 'sanjana@gmail.com', mobile: '9988556677', city: 'bangalore'})