class Movie 
  attr_reader :title,
              :id,
              :overview,
              :vote_average,
              :vote_count,
              :poster_path,
              :runtime, 
              :genres

  def initialize(response)
    @title = response[:title]
    @id = response[:id]
    @overview = response[:overview]
    @vote_average = response[:vote_average]
    @vote_count = response[:vote_count]
    @poster_path = response[:poster_path]
    @runtime = response[:runtime]
    @genres = response[:genres]
  end
end