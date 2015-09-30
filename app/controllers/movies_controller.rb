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
    @movies = Movie.where("title like ?", "%#{params[:title]}%").where("director like ?", "%#{params[:director]}%").where(movie_durationn_query[params[:duration]])
  end

  protected

  def movie_duration_query
    field = "runtime_in_minutes "
    {
      '< 90' =>  field + '< 90',
      'between 90 and 120' => field + 'between 90 and 120',
      '> 120' => field + '> 120'
    }
  end

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image, :description
    )
  end
end
  