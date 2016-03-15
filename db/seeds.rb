# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times do
  Contact.create(name: [*('A'..'Z'),*('a'..'z'), *(0..9)].sample(7).join, number: [*(1..9)].sample(10).join)
end
