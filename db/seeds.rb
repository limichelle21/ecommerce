# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

include Faker

10.times do 
	owner = Owner.create!(
		email: Faker::Internet.email,
		password: Faker::Internet.password
		)
	end

owners = Owner.all

20.times do
	store = Store.create!(
		owner: owners.sample,
		name: Faker::Company.name
		)
end

stores = Store.all

40.times do 
	product = Product.create!(
		store: stores.sample,
		title: Faker::Commerce.product_name,
		price: Faker::Commerce.price,
		description: Faker::Lorem.sentence,
		sku: Faker::Number.number(4),
		count: Faker::Number.digit
		)
end

products = Product.all


puts "Seeds finished."
puts "#{Owner.count} owners created."
puts "#{Store.count} stores created."
puts "#{Product.count} products created."



