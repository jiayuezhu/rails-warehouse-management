# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
Product.delete_all
puts "products deleted"
List.delete_all
puts "lists deleted"
Bill.delete_all
puts "bills deleted"
# Wholesale.delete_all
# puts "wholesales deleted"
Detail.delete_all
puts "details deleted"
Description.delete_all
puts "descriptions deleted"

# puts "start generating new seeds"


# 10.times do
#   Product.create(name: Faker::Kpop.solo,
#                  model: Faker::Address.postcode,
#                  color: Faker::Color.color_name,
#                  category: ['electronic', 'kitchens', 'food', 'books'].sample,
#                  purchase_price: Faker::Number.decimal(2),
#                  storage: Faker::Number.between(1, 10))
# end
# puts "products made"

# 3.times do
#   Bill.create(notes: Faker::Kpop.solo)
# end
# puts "bills made"


# Bill.all.each do |b|
#   3.times do
#     List.create(buyer: Faker::Name.first_name,
#                 bill_id: b.id)
#   end
# end
# puts "lists made"

# List.all.each do |l|
#   3.times do
#     Wholesale.create(product_id: (0..10).to_a.sample,
#                      list_id: l.id)
#   end
# end
# puts "wholesales made"












