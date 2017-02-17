require_relative('./models/customer.rb')
require_relative('./models/film.rb')
require_relative('./models/ticket.rb')
require('pry-byebug')

# CUSTOMERS
customer1 = Customer.new({"customer_name" => "Desperate Dan", "customer_funds" => 20})
customer1.save()

customer2 = Customer.new({"customer_name" => "Peter Pan", "customer_funds" => 55})
customer2.save()

customer3 = Customer.new({"customer_name" => "Donald Trump", "customer_funds" => 10000000})
customer3.save()

# FILMS

film1 = Film.new({"film_title" => "The Long Weekend", "film_price" => 10})
film1.save()

film2 = Film.new({"film_title" => "Godzilla", "film_price" => 10})
film2.save()

film3 = Film.new({"film_title" => "Big Mommas House 5", "film_price" => 10})
film3.save()

# TICKETS

ticket1 = Ticket.new({"film_id" => film1.film_id, "customer_id" => customer1.customer_id})
ticket1.save()

binding.pry
nil