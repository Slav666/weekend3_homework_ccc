require_relative('./db/sql_runner')
require_relative('film')

class Ticket

  attr_accessor :customer_name, :film_id
  attr_reader :id

  def initialize(options)
    @id = options['id'] if options['id'].to_i
    @film_id = options['film_id'].to_i
    @customer_name = options['customer_name']
  end

  def what_film_is_ticket_for()
    sql = "SELECT * FROM movies WHERE ticket_id = $1"
    values = [@id]
    movie_hashes = SqlRunner.run(sql, values)
    movie_objects = movie_hashes.map { |movie_hash| Film.new(movie_hash) }
    return movie_objects
  end


  def save() sql = "INSERT INTO tickets(customer_name) VALUES($1, $2) RETURNING *"
    values = [@film_id, @customer_name]
    returned_array = SqlRunner.run(sql, values)
    customer_name_hash = returned_array[0]
    id_string = customer_name_hash['id']
    @id = id_string.to_i
  end


  def update()
    sql = "UPDATE tickets SET (ticket_id, customer_name) = ($1, $2) WHERE id = $3"
    values = [@ticket_id, @customer_name, @id]
    SqlRunner.run(sql, values)
  end


  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM tickets WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    customer_name_hash = results.first
    customer_name = Ticket.new(customer_name_hash)
    return customer_name
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    customer_name_hashes = SqlRunner.run(sql)
    customer_name_objects = customer_name_hashes.map{|ticket| Ticket.new(ticket)}
    return customer_name_objects
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

end
