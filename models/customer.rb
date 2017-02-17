require_relative('../sql_runner.rb')

class Customer

  attr_reader :customer_id
  attr_accessor :name, :funds

  def initialize(options)
    @customer_name = options["customer_name"]
    @customer_funds = options["customer_funds"].to_i
    @customer_id = options["customer_id"] if options["customer_id"].to_i
  end

  def save()

    sql = "INSERT INTO customers (customer_name, customer_funds)
          VALUES ('#{@customer_name}', #{@customer_funds}) 
          RETURNING *;"

    result = SqlRunner.run(sql)
    puts result

  end

end