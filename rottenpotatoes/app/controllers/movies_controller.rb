class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    
    if params[:ratings]
      @ratings_to_show = params[:ratings]
    elsif session[:ratings]
      @ratings_to_show = session[:ratings]
    else
      @ratings_to_show = Hash[@all_ratings.map {|key| [key, 1]}]
    end
   
    if params[:order]
      sorted = params[:order]
    elsif session[:order]
      sorted = session[:order]
    end
    
    if sorted
      if sorted == 'title'
        ordered, @title_header = {:title => :asc}, "hilite bg-warning"
      elsif sorted == 'release_date'
        ordered, @release_date_header = {:release_date => :asc}, "hilite bg-warning"
      end
    end
    
    if (params[:ratings] == nil && session[:order] != nil) ||
      (params[:order] == nil && session[:order] != nil)
      flash.keep
      redirect_to movies_path :order => sorted, :ratings => @ratings_to_show and return
    end
    
    @movies = Movie.where(rating: @ratings_to_show.keys).order(ordered)
    
    session[:order] = sorted
    session[:ratings] = @ratings_to_show

  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  def search
    @movie = Movie.find(params[:id])
    if @movie.director.present?
      @movies = Movie.find_same_director(@movie.director)
    else
      flash[:notice] = "'#{@movie.title}' has no director info" 
      redirect_to movies_path
    end
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :director, :release_date)
  end
end
