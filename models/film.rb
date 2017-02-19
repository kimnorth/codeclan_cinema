require_relative('../sql_runner.rb')
require_relative('./customer.rb')

class Film

  attr_accessor :film_title, :film_price
  attr_reader :film_id

  def initialize(options)
    @film_title = options["film_title"]
    @film_price = options["film_price"]   
    @film_id = options["film_id"] if options["film_id"]
  end

  def save()
    sql = "INSERT INTO films 
          (film_title, film_price)
          VALUES
          ('#{@film_title}', #{@film_price})
          RETURNING *;"
    film = SqlRunner.run(sql).first
    @film_id = film["film_id"].to_i
  end

  def self.read()
    sql = "SELECT * FROM films;"
    list_of_films = SqlRunner.run(sql)
    film_objects = list_of_films.map {|film| Film.new(film)}
    return film_objects
  end

  def delete()
    sql = "DELETE FROM films
          WHERE film_id = '#{@film_id}';"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE films SET
          (film_title, film_price) = 
          ('#{@film_title}', #{@film_price})
          WHERE film_id = #{@film_id};"
    SqlRunner.run(sql)
  end

  def customers()

    # get customer ids from tickets where the film id matches
    tickets_sql = "SELECT customer_id FROM tickets
                   WHERE film_id = #{@film_id};"
    returned_customer_list = SqlRunner.run(tickets_sql)  
    customer_array = []
    for customer in returned_customer_list
      customer_array.push(customer)
    end
    return customer_array.length

  end



end