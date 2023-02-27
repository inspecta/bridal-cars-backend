class Api::V1::CarsController < ApplicationController
  # Show all cars
  def index
    @cars = Car.all
    render json: @cars
  end

  # Add a car
  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @car.save
    render json: @car
  end

  # Delete a car
  def destroy
    @cars = Car.all
    @car = Car.find(params[:id])
    @car.destroy
    render json: @cars
  end

  # required parameters
  private

  def car_params
    params.require(:car).permit(:name, :model, :photo)
  end
end
