require_relative('../sql_runner.rb')
require_relative('./customer.rb')
require_relative('./film.rb')

class Ticket

  def initialize(options)
    @ticket_id = options["ticket_id"] if options["ticket_id"]
    @film_id = options["film_id"]
    @ticket_time = options["ticket_time"]
    @customer_id = options["customer_id"]
  end

  def save()
    sql = "INSERT INTO tickets
          (film_id, film_time, customer_id)
          VALUES
          (#{@film_id}, '#{@ticket_time}', #{@customer_id})
          RETURNING *;"
    results = SqlRunner.run(sql).first
    @ticket_id = results["ticket_id"]
    deduct_from_customer_funds()
  end

  def deduct_from_customer_funds

    # Price of associated film:
    sql_film_price = "SELECT * FROM films WHERE film_id = #{@film_id};"
    returned_film = SqlRunner.run(sql_film_price).first
    film_price = returned_film["film_price"].to_i
    
    # Get back a customer object:
    sql_customer = "SELECT * FROM customers WHERE customer_id = #{@customer_id};"
    returned_customer = SqlRunner.run(sql_customer).first
    customer_object = Customer.new(returned_customer)
    
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

  def self.most_tickets_sold

    # Get back films as objects
    sql_get_films = "SELECT * FROM films;"
    array_of_films = SqlRunner.run(sql_get_films)
    film_objects = array_of_films.map {|film| Film.new(film)}

    # Push film name, tickets sold into an array of hashes

    film_tickets_sold_array = []

    for film_object in film_objects
      film_tickets_sold_array << {"film_title" => film_object.film_title, "film_id" => film_object.film_id, "tickets_sold" => film_object.customers}
    end

    film_tickets_sold_array.sort_by! {|film| film["tickets_sold"]}
    return film_tickets_sold_array.last

    # unfinished...

  end

end