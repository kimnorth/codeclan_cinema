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