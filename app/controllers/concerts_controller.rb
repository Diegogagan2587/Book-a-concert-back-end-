class ConcertsController < ApplicationController
  def index
    @concerts = Concert.all
    concerts_hash = @concerts.as_json
    concerts_hash.each do |c|
      organizer_name = User.find(c['organizer_id']).name
      c['organizer_name'] = organizer_name
    end
    render json: concerts_hash
  end

  def show
    @concert = Concert.find(params[:id])
    concert_hash = @concert.as_json
    organizer_name = User.find(concert_hash['organizer_id']).name
    concert_hash['organizer_name'] = organizer_name
    render json: concert_hash
  end

  def create
    @concert = Concert.new(concert_params)
    if @concert.save
      render json: { message: 'Concert created successfully' }
    else
      render json: { errors: @concert.errors.full_messages }
    end
  end

  def current_user_concerts
    @current_user = User.find_by(logged: true)
    if @current_user
      @concerts = @current_user.concerts
      concerts_hash = @concerts.as_json
      concerts_hash.each do |c|
        organizer_name = User.find(c['organizer_id']).name
        c['organizer_name'] = organizer_name
      end
      render json: concerts_hash
    else
      render json: { message: 'nobody has logged in, do that first to see the concerts' }
    end
  end

  def destroy
    @concert = Concert.find_by(id: params[:id])

    if @concert
      if @concert.destroy
        render json: { message: 'Concert deleted successfully and all its reservations' }
      else
        render json: { error: 'Failed to delete the concert' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Concert not found' }, status: :not_found
    end
  end

  private

  def concert_params
    params.require(:concert).permit(:title, :organizer_id, :description, :img, :price, :date, :city)
  end
end
