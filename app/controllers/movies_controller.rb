class MoviesController < ApplicationController

  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  def search
    # @movies = Movie.where("title like ? AND director like ? AND runtime_in_minutes #{params[:duration]}", "%#{params[:title]}%", "%#{params[:director]}%")
    query = movie_duration_query[params[:duration]]
    @movies = Movie.search_by_title(params[:title]).search_by_director(params[:director])
    @movies = @movies.send(query) if query
  end


  def movie_duration_query
  {
    'short' =>  :less_than_90_minutes,
    'medium' => :between_90_and_120_minutes,
    'long' => :greater_than_120_minutes
  }
  end

  protected

  
  

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image, :description
    )
  end
end
  