require('pry')
require_relative('film')
require_relative('ticket')


Ticket.delete_all
Film.delete_all


film1 = Film.new({'title' => 'The Matrix', 'director_name' => 'Wachowski'})
film1.save
# film2 = Film.new({'title' => 'Fight Club', 'director_name' => 'David Fincher'})
# film3 = Film.new({'title' => 'Flank', 'director_name' => 'Boby'})
ticket1 = Ticket.new({'customer_name' => 'Theresa May'})
ticket1.save







   binding.pry
  nil
