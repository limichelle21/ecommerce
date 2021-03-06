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
		password: Faker::Internet.password,
		name: Faker::Name.name,
		street_address: Faker::Address.street_address,
		city: Faker::Address.city,
		state: Faker::Address.state_abbr,
		zip_code: Faker::Address.zip_code,
		phone_number: Faker::PhoneNumber.phone_number
		)
end

customers = Customer.all


20.times do
	store = Store.create!(
		owner: owners.sample,
		name: Faker::Company.name,
        description: Faker::Lorem.paragraph(3),
        about: Faker::Lorem.sentence(1),
        action_call: Faker::Company.catch_phrase
		)
end


stores = Store.all

100.times do 
	product = Product.create!(
		store: stores.sample,
		title: Faker::Commerce.product_name,
		price_in_cents: Faker::Number.between(1, 1000),
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



