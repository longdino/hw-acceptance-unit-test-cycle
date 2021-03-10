class Movie < ActiveRecord::Base
    def self.all_ratings
        ['G', 'PG', 'PG-13', 'R', 'NC-17']
    end
    def self.with_ratings(ratings_list)
        if ratings_list
            Movie.where(rating: ratings_list.keys)
        else
            Movie.all
        end   
    end
end
