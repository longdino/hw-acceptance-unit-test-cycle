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
end