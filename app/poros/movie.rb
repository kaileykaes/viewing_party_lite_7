class Movie 
  attr_reader :title,
              :id,
              :summary,
              :vote_average,
              :vote_count,
              :image_url,
              :runtime, 
              :genres

  def initialize(response)
    @title = response[:title]
    @id = response[:id]
    @summary = response[:summary]
    @vote_average = response[:vote_average]
    @vote_count = response[:vote_count]
    @image_url = response[:image_url]
    @runtime = response[:runtime]
    @genres = response[:genres]
  end
end