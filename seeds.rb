require_relative('./models/customer.rb')
require_relative('./models/film.rb')
require('pry-byebug')

# 
customer1 = Customer.new({"customer_name" => "Desperate Dan", "customer_funds" => 20})
customer1.save()

film1 = Film.new({"film_title" => "The Long Weekend", "film_price" => 10})
film1.save()

binding.pry
nil