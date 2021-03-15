require 'rails_helper'

RSpec.describe Movie, type: :model do
    describe 'Similar Movies With Director' do
        it 'should return the similar movies with same director' do
            movie1 = Movie.create!(title: 'title1', director: 'director1')
            #movie2 = Movie.create!(title: 'title2', director: 'director2')
            movie3 = Movie.create!(title: 'title3', director: 'director1')
            
            expect(Movie.find_same_director('director1')).to eq [movie1, movie3]
        end
    end
    
    describe 'All Ratings' do 
        it 'should show all ratings' do
            expect(Movie.all_ratings).to eq ['G', 'PG', 'PG-13', 'R', 'NC-17']
        end
    end
    
end