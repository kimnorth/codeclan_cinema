require_relative('../sql_runner.rb')
require_relative('./customer.rb')

class Ticket

  def initialize(options)
    @ticket_id = options["ticket_id"] if options["ticket_id"]
    @film_id = options["film_id"]
    @customer_id = options["customer_id"]
  end

  def save()
    sql = "INSERT INTO tickets
          (film_id, customer_id)
          VALUES
          (#{@film_id}, #{@customer_id})
          RETURNING *;"
    results = SqlRunner.run(sql).first
    @ticket_id = results["ticket_id"]
    deduct_from_customer_funds()
  end

  def deduct_from_customer_funds

    # We need to update the associated customer entry by removing the price of the associated film.

    # We could create a customer object, deduct the price of the film by searching the database by film id, then use the customer's update method to update the database.

    # Price of associated film:
    sql_film_price = "SELECT * FROM films WHERE film_id = #{@film_id};"
    returned_film = SqlRunner.run(sql_film_price).first
    film_price = returned_film["film_price"].to_i
    
    # Get back a customer object:
    sql_customer = "SELECT * FROM customers WHERE customer_id = #{@customer_id};"
    returned_customer = SqlRunner.run(sql_customer).first
    customer_object = Customer.new(returned_customer)
    customer_object

    # Deduct film price from customer object's funds
    customer_object.customer_funds -= film_price

    # Update entry in customer database
    customer_object.update()

  end

  def self.read()
    sql = "SELECT * FROM tickets;"
    array_of_tickets = SqlRunner.run(sql)
    ticket_objects = array_of_tickets.map {|ticket| Ticket.new(ticket)}
    return ticket_objects
  end

  def delete()
    sql = "DELETE FROM tickets
           WHERE ticket_id = #{@ticket_id};"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM tickets;"
    SqlRunner.run(sql)
  end

end