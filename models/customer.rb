require_relative('../sql_runner.rb')
require_relative('./ticket.rb')

class Customer

  attr_reader :customer_id
  attr_accessor :customer_name, :customer_funds

  def initialize(options)
    @customer_name = options["customer_name"]
    @customer_funds = options["customer_funds"].to_i
    @customer_id = options["customer_id"] if options["customer_id"].to_i
  end

  def save()
    sql = "INSERT INTO customers (customer_name, customer_funds)
          VALUES ('#{@customer_name}', #{@customer_funds}) 
          RETURNING *;"
    customer = SqlRunner.run(sql).first
    @customer_id = customer["customer_id"].to_i
  end

  def self.read()
    sql = "SELECT * FROM customers;"
    array_of_customers = SqlRunner.run(sql)
    customer_objects = array_of_customers.map {|customer| Customer.new(customer)}
    return customer_objects
  end

  def delete()
    sql = "DELETE FROM customers WHERE customer_id = '#{@customer_id}';"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE customers SET
    (customer_name, customer_funds) = 
    ('#{@customer_name}', #{@customer_funds})
    WHERE customer_id = #{@customer_id};"
    SqlRunner.run(sql)
  end

  def tickets()
    sql = "SELECT * FROM tickets
           WHERE customer_id = #{@customer_id};"
    array_of_tickets = SqlRunner.run(sql)
    ticket_list = array_of_tickets.map {|ticket| Ticket.new(ticket)}
    return ticket_list
  end

end