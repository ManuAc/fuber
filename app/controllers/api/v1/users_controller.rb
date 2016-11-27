class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :set_user

  def cabs
    latitude = params[:latitude]
    longitude = params[:longitude]

    city = params[:city] || @user.city

    if latitude && longitude
      location = Location.new({latitude: latitude, longitude: longitude})
      cabs = Cab.list_cabs(city, location)
    end

    if cabs.present?
      data = prepare_data(cabs)
      render json: success(data) and return
    else
      render json: not_available and return
    end
  end

  def book
    latitude = params[:latitude]
    longitude = params[:longitude]
    ctype = params[:ctype]

    city = params[:city] || @user.city

    if latitude && longitude
      location = Location.new({latitude: latitude, longitude: longitude})
      trip = Cab.book_cab(@user, city, location, ctype)
    end

    if trip.present?
      render json: success(trip) and return
    else
      render json: not_available and return
    end
  end

  protected

  def set_user
    @user = User.find_by_id(params[:id])
    unless @user.present?
      render json: failure('Ahh!!! User not found!') and return
    end
  end

  def success(data)
    response = {}
    response[:status] = :success
    response[:code] = 200
    response[:data] = data
    response.to_json
  end

  def failure
    response = {}
    response[:status] = :failure
    response[:code] = 400
    response[:error] = {
      message: message.present? ? message : 'Oops!!! Something went wrong, try in sometime!'
    }
    response.to_json
  end

  def not_available
    response = {}
    response[:status] = :success
    response[:code] = 404
    response[:data] = {
      message: 'Oops!!! No cabs are available, try in sometime!'
    }
    response.to_json  
  end

  def prepare_data(cabs)
    data = []
    cabs.each do |cab|
      obj = {}
      obj[:name] = cab.name
      obj[:model] = cab.model
      obj[:number] = cab.number
      obj[:ctype] = cab.ctype
      obj[:current_location] = cab.current_location
      obj[:driver] = cab.driver
      data << obj
    end
    data
  end
end
