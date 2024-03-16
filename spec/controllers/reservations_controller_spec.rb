# class ReservationsController < ApplicationController
#   def index
#     @reservations = Reservation.all
#     render json: @reservations, status: :ok
#   end

#   def show
#     @reservation = Reservation.find(params[:id])
#     render json: @reservation, status: :ok
#   end

#   def create
#     @reservation = Reservation.new(reservation_params)

#     if @reservation.save
#       render json: { message: 'Reservation created successfully' }, status: :created
#     else
#       render json: { errors: @reservation.errors.full_messages }, status: :unprocessable_entity
#     end
#   end

#   def current_user_reservations
#     @current_user = User.find_by(logged: true)
#     if @current_user
#       @reservations = @current_user.reservations
#       render json: @reservations, status: :ok
#     else
#       render json: { message: 'You are not logged in' }, status: :unauthorized
#     end
#   end

#   private

#   def reservation_params
#     params.require(:reservation).permit(:user_id, :concert_id, :date, :city)
#   end
# end

require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    context 'when there are reservations' do
      before do
        User.create(name: 'TestUser')
        Concert.create(
          title: 'TestConcert',
          organizer_id: User.find_by(name: 'TestUser').id,
          description: 'TestDescription',
          img: 'TestImg',
          price: 10.0,
          date: '2021-11-04',
          city: 'TestCity'
        )
        Reservation.create(
          user_id: User.find_by(name: 'TestUser').id,
          concert_id: Concert.find_by(title: 'TestConcert').id,
          date: '2021-11-04',
          city: 'TestCity'
        )
      end

      it 'returns all reservations' do
        get :index
        expect(JSON.parse(response.body).size).to eq(1)
      end

      it 'return the reservations of the current user' do
        get :index
        expect(JSON.parse(response.body)[0]).to include('user_id' => User.find_by(name: 'TestUser').id)
      end
    end
  end
end
