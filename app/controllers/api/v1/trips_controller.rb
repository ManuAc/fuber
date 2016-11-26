class Api::V1::TripsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :set_trip

  def start
    latitude = params[:latitude]
    longitude = params[:longitude]

    if @trip.start(Location.new(latitude: latitude, longitude: longitude))
      render json: success(@trip) and return
    else
      render json: failure and return
    end
  end

  def end
    latitude = params[:latitude]
    longitude = params[:longitude]

    if @trip.end(Location.new(latitude: latitude, longitude: longitude))
      render json: success(@trip) and return
    else
      render json: failure and return
    end
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
    unless @trip.present?
      render json: failure("Ahh!!! Trip not found!") and return
    end
  end

  def success(data)
    response = {}
    response[:status] = :success
    response[:code] = 200
    response[:data] = data
    response.to_json
  end

  def failure(message = '')
    response = {}
    response[:status] = :failure
    response[:code] = 400
    response[:error] = {
      message: message.present? ? message : 'Oops!!! Something went wrong, try in sometime!'
    }
    response.to_json
  end
end