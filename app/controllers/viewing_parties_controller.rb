class ViewingPartiesController < ApplicationController
  def new
    @party = ViewingParty.new 
    @host = User.find(params[:user_id])
    @facade = MovieFacade.new(params[:movie_id])
    @movie = @facade.movie(params[:movie_id])
    @users = User.where.not(id: @host.id)
  end

  def create 
    @party = ViewingParty.new(party_params)
    @host = User.find(params[:user_id])

    if @party.save 
      
      ViewingPartyUsers.create(user_id: @party.user_id, viewing_party_id: @party.id)
      redirect_to (user_path(@host))

      #for sad path have error message if duration is shorter than runtime
    end
  end


  private 

  def party_params
    params.permit(:duration, :date, :time, :host_id, :movie_id)

  end
end