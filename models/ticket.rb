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

end