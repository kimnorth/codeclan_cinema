require_relative('../sql_runner.rb')

class Film

  attr_accessor :name, :funds
  attr_reader :id

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

  def delete()
    sql = "DELETE FROM films
          WHERE film_id = '#{@film_id}';"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end

end