class Review 
  attr_reader :review_id,
              :author, 
              :content,
              :rating

  def initialize(response)
    @review_id = response[:id]
    @author = response[:author]
    @content = response[:content]
    author = response[:author_details]
    @rating = author[:rating]
  end
end