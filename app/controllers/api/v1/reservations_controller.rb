class Api::V1::ReservationsController < ApplicationController
  def index
    reservations = Reservation.where(user_id: params[:user_id])
    response = []
    reservations.each do |res|
      response << {
        id: res.id,
        city: res.city,
        reservation_date: res.reservation_date,
        duration: res.duration,
        user_id: res.user_id,
        car: CarSerializer.new(Car.find(res.car_id))
      }
    end
    render json: response, status: 200
  end

  def create
    reservation = Reservation.new(reservation_params)
    response = {
      city: reservation.city,
      user_id: reservation.user_id,
      duration: reservation.duration,
      date_reserved: reservation.reservation_date,
      car: CarSerializer.new(Car.find(reservation.car_id))
    }

    if reservation.save
      render json: response, status: 200
    else
      render json: { errors: 'Reservation not created' }, status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:car_id, :user_id, :reservation_date, :duration, :city)
  end
end
