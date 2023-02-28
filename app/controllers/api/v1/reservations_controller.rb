class Api::V1::ReservationsController < ApplicationController
  def index
    jwt_payload = JWT.decode(request.headers['Authorization'].split[1], Rails.application.secret_key_base).first
    current_user = User.find(jwt_payload['sub'])
    reservations = Reservation.where(user_id: current_user)

    reservations.each do |res|
      response << {
        id: res.id,
        city: res.city,
        reservation_date: res.reservation_date,
        duration: res.duration,
        user_id: res.user_id,
        car: CarSerializer.new(Car.find(res.car_id))
        
      }
      render json: response, status: 200
  end

  def create
  end

  private

  def reservation_params
    params.require(:reservation).permit(:car_id, :user_id, :reservation_date, :duration, :city)
  end
end
