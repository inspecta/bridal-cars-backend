class Api::V1::CarsController < ApplicationController
  def index
    @cars = Car.all
    render json: @cars
  end

  def show
    @car = Car.find(params[:id])
    render json: @car
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @car.save
    render json: @car
  end

  def update
    @car = Car.find(params[:id])
    if @car.update(car_params)
      render json: { message: ' Car is successfully updated!' }
    else
      render json: @car.errors, status: unprocessable_entity
    end
  end

  def destroy
    @cars = Car.all
    @car = Car.find(params[:id])
    @car.destroy
    render json: @cars
  end

  private

  def car_params
    params.require(:car).permit(:name, :model, :photo, :price, :description, :reserved)
  end
end
