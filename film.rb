require_relative('./db/sql_runner')
require_relative('ticket')

class Film

attr_accessor :title, :director_name
attr_reader :id

def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @director_name = options['director_name']
    @ticket_id = options['ticket_id'].to_i
end

def which_ticket_sold()
    sql = "SELECT * FROM tickets
    WHERE id = $1"
    values = [@ticket_id]
    results = SqlRunner.run(sql, values)
    ticket_hash = results[0]
    ticket = Ticket.new(ticket_hash)
    return ticket
end


def save()
    sql = "INSERT INTO movies (ticket_id, title, director_name) VALUES ($1, $2, $3) RETURNING id"
    values = [@ticket_id, @title, @director_name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
end

def update()
    sql = "UPDATE movies SET (ticket_id, title, director_name) = ($1, $2, $3) WHERE id = $4"
    values = [@ticket_id, @title, @director_name, @id]
    SqlRunner.run(sql, values)
end

def delete()
    sql = "DELETE FROM movies
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

def self.find(id)
   sql = "SELECT * FROM movies WHERE id = $1"
   values = [id]
   results = SqlRunner.run(sql, values)
   movie_hash = results.first
   movie = Film.new(movie_hash)
   return movie
end

def self.delete_all()
   sql = "DELETE FROM movies"
   SqlRunner.run(sql)
end

def self.all()
    sql = "SELECT * FROM movies"
    movies_hashes = SqlRunner.run(sql)
    movies = movies_hashes.map { |movie| Film.new( movie ) }
    return movies
end
end
