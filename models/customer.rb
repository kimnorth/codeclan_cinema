require_relative('../sql_runner.rb')

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
    ('#{@customer_name}', #{@customer_id})
    WHERE customer_id = #{@customer_id};"
    SqlRunner.run(sql)
  end

end