class MovieFacade
  attr_reader :search
  
  def initialize(search = nil)
    @search = search
  end

  
  def top_movies
    movies = service.top_movies
    create_movies(movies)
  end

  def search_movies
    movies = service.search_movies(search)
    create_movies(movies)
  end

  def service 
    MovieService.new
  end
  
  def create_movies(movies_data)
    movies_data[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end
end