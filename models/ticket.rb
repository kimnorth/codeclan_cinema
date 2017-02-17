require_relative('../sql_runner.rb')

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

    # Run SQL that updates the customer_funds by deducting the cost of the ticket from the film

    sql_deduct_ticket = "UPDATE customers 
                        SET (customer_funds) =
                        (#{@customer_funds} -10);" # not working - currently sets to minus 10
    SqlRunner.run(sql_deduct_ticket)


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