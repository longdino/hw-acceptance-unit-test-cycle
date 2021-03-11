# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

movies = [{:title => 'Aladdin', :rating => 'G', :director => 'Ron Clements', :release_date => '25-Nov-1992'},
    	  {:title => 'The Terminator', :rating => 'R', :director => 'James Cameron', :release_date => '26-Oct-1984'},
    	  {:title => 'When Harry Met Sally', :rating => 'R', :director => 'Rob Reiner', :release_date => '21-Jul-1989'},
      	  {:title => 'The Help', :rating => 'PG-13', :director => 'Tate Taylor', :release_date => '10-Aug-2011'},
      	  {:title => 'Chocolat', :rating => 'PG-13', :director => 'Lasse Hallstrom', :release_date => '5-Jan-2001'},
      	  {:title => 'Amelie', :rating => 'R', :director => 'Jean-Pierre Jeunet', :release_date => '25-Apr-2001'},
      	  {:title => '2001: A Space Odyssey', :rating => 'G', :director => 'Stanley Kubrick', :release_date => '6-Apr-1968'},
      	  {:title => 'The Incredibles', :rating => 'PG', :director => 'Brad Bird', :release_date => '5-Nov-2004'},
      	  {:title => 'Raiders of the Lost Ark', :rating => 'PG', :director => 'Steven Spielberg', :release_date => '12-Jun-1981'},
      	  {:title => 'Chicken Run', :rating => 'G', :director => 'Nick Park', :release_date => '21-Jun-2000'},
  	 ]

movies.each do |movie|
  Movie.create!(movie)
end