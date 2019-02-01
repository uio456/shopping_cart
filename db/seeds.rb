# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Vendor.destroy_all

vendor_list = [
  {name: "Nike"},
  {name: "BoBoCar"},
  {name: "Shopee"},
  {name: "Eslite"}
]

vendor_list.each do |vendor|
  Vendor.create( name: vendor[:name])
  puts "#{vendor[:name]} has created!"
end

#Default admin
# User.create(email: "root@example.com", password: "12345678", role: "admin", name: "Duncan")
# puts "Default admin create!"