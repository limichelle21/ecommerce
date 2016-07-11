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

	owner = Owner.create!(
	   name:     'Admin User',
	   email:    'limichelle21@gmail.com',
	   password: 'helloworld',
	 )

owners = Owner.all

10.times do 
	customer = Customer.create!(
		email: Faker::Internet.email,
		password: Faker::Internet.password
		)
end

customers = Customer.all


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
		price_in_cents: Faker::Commerce.price,
		description: Faker::Lorem.sentence,
		sku: Faker::Number.number(4),
		count: Faker::Number.digit
		)
end

products = Product.all


20.times do
	order = Order.create!(
		store: stores.sample,
		customer: customers.sample,
		price_in_cents: Faker::Commerce.price,
		completed: [true, false].sample,
		date_paid: Faker::Date.backward(365)
		)
end

orders = Order.all

60.times do
	order_line = OrderLine.create!(
		product: products.sample, 
		order: orders.sample,
		quantity: Faker::Number.number(2),
		price_in_cents: products.sample.price_in_cents
		)
end

order_lines = OrderLine.all



puts "Seeds finished."
puts "#{Owner.count} owners created."
puts "#{Customer.count} customers created"
puts "#{Store.count} stores created."
puts "#{Product.count} products created."
puts "#{Order.count} orders created."
puts "#{OrderLine.count} order lines created."



