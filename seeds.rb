require_relative('./models/customer.rb')
require('pry-byebug')

customer1 = Customer.new({"customer_name" => "Desperate Dan", "customer_funds" => 20})
customer1.save()

binding.pry
nil