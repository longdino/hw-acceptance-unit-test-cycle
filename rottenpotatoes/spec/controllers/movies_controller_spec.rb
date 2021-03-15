require 'rails_helper'
require 'factory_girl_rails'

if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

RSpec.describe MoviesController, type: :controller do
    
    describe 'Show Movies' do
        it 'should show the movies' do
            movie1 = Movie.create!(title: 'title1')
            get :show, { id: movie1.to_param }
            expect(assigns(:movie)).to eq movie1
        end
    end
    
    describe 'Index Movies' do
        it 'should show all movies in the list' do
            get :index
            expect(assigns(:movies).length).to eq(Movie.all.count)
        end
        
        it 'should highlight title when title clicked' do
            get :index, { order: 'title' }
            expect(assigns(:title_header)).to eq('hilite bg-warning')
            expect(assigns(:release_date_header)).to eq(nil)
        end
        
        it 'should highlight release date when release date clicked' do
            get :index, { order: 'release_date' }
            expect(assigns(:release_date_header)).to eq('hilite bg-warning')
            expect(assigns(:title_header)).to eq(nil)
        end
    end
    
    describe 'Create Movies' do
        it 'should create movies' do
            post :create, movie: {title: 'title1', director: 'director1', rating: 'PG', release_date: '2021-03-14'}
            expect(flash[:notice]).to eq "title1 was successfully created."
            expect(response).to redirect_to movies_path 
        end
    end
    
    describe 'Edit Movies' do
        it 'should edit the movie' do
            movie2 = Movie.create!(title: 'title')
            
            get :edit, { id: movie2.to_param }
            expect(assigns(:movie)).to eq movie2
        end
    end
    
    describe 'Update Movies' do
        it 'should update the movie' do
            movie3 = Movie.create!(title: 'title1')
            movie3.update_attributes(title: 'TITLE')
            
            put :update, { id: movie3.id, movie: movie3.attributes }
            expect(assigns(:movie)).to eq movie3
            expect(flash[:notice]).to eq "TITLE was successfully updated."
            expect(response).to redirect_to(movie3)
        end
    end
    
    describe 'Delete Movies' do
        it 'should delete the movie' do
            movie4 = Movie.create!(title: 'title1')
            
            delete :destroy, { id: movie4.id }
            expect(flash[:notice]).to eq "Movie 'title1' deleted."
            expect(response).to redirect_to movies_path
        end
    end
    
    describe 'Search Movies' do
        it 'should return the similar movies with director if director exists' do
            movie5 = Movie.create!(title: 'title1', director: 'director1')
            movie6 = Movie.create!(title: 'title3', director: 'director1')
            
            get :search, { id: movie5.id }
            expect(assigns(:movies)).to eq [movie5, movie6]
        end
        it 'should return to home page if director does not exist' do
            movie7 = Movie.create!(title: 'title1', director: '')
            
            get :search, { id: movie7.id }
            expect(flash[:notice]).to eq "'title1' has no director info"
            expect(response).to redirect_to movies_path
        end
    end
end