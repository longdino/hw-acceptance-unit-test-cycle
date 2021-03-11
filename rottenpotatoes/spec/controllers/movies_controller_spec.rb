require 'rails_helper'

RSpec.describe Movie, type: :model do
    describe 'Similar Movies With Director' do
        it 'should return the similar movies with director if director exists' do
            movie1 = Movie.create!(title: 'title1', director: 'director1')
            movie2 = Movie.create!(title: 'title2', director: 'director2')
            movie3 = Movie.create!(title: 'title3', director: 'director1')
            
            get :serach, {:id => movie1.to_param}
            expect(assigns(:movies)).to eq [movie1, movie3]
        end
        it 'should return to home page if director does not exist' do
            movie = Movie.create!(title: 'title1', director: '')
            
            get :serach, {:id => movie.to_param}
            expect(flesh[:notice]).to eq "'title1' has no director info"
            expect(response).to redirect_to movies_path
        end
    end
end