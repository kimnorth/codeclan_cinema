require_relative('./models/customer.rb')
require_relative('./models/film.rb')
require_relative('./models/ticket.rb')
require('pry-byebug')

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()

# CUSTOMERS
customer1 = Customer.new({"customer_name" => "Desperate Dan", "customer_funds" => 20})
customer1.save()

customer2 = Customer.new({"customer_name" => "Peter Pan", "customer_funds" => 55})
customer2.save()

customer3 = Customer.new({"customer_name" => "Donald Trump", "customer_funds" => 10000000})
customer3.save()

customer4 = Customer.new({"customer_name" => "Sigmund Freud", "customer_funds" => 20000})
customer4.save()


# FILMS

film1 = Film.new({"film_title" => "The Long Weekend", "film_price" => 10})
film1.save()

film2 = Film.new({"film_title" => "Godzilla", "film_price" => 10})
film2.save()

film3 = Film.new({"film_title" => "Big Mommas House 5", "film_price" => 10})
film3.save()

# TICKETS

# Desperate Dan sees The Long Weekend
ticket1 = Ticket.new({"film_id" => film1.film_id, "customer_id" => customer1.customer_id, "ticket_time" => "14:30"})
ticket1.save() 

# Peter Pan sees The Long Weekend
ticket2 = Ticket.new({"film_id" => film1.film_id, "customer_id" => customer2.customer_id, "ticket_time" => "16:40"})
ticket2.save()

# Desperate Dan sees Big Momma's House
ticket3 = Ticket.new({"film_id" => film3.film_id, "customer_id" => customer1.customer_id, "ticket_time" => "18:30"})
ticket3.save()

# Donald Trump sees Godzilla
ticket4 = Ticket.new({"film_id" => film2.film_id, "customer_id" => customer3.customer_id, "ticket_time" => "20:30"})
ticket4.save()

# Donald Trump sees Big Momma's House
ticket5 = Ticket.new({"film_id" => film3.film_id, "customer_id" => customer3.customer_id, "ticket_time" => "18:30"})
ticket5.save()

ticket6 = Ticket.new({"film_id" => film3.film_id, "customer_id" => customer4.customer_id, "ticket_time" => "19:00"})
ticket6.save()



binding.pry
nil