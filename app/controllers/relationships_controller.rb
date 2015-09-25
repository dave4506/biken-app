class RelationshipsController < ApplicationController
  before_action :user?,      only: [:create, :destroy]

  def create
    @ride = Ride.find(params[:ride_id])
    current_user.going(@ride)
    respond_to do |format|
      format.html { redirect_to rides_url() }
      format.js
    end
  end

  def destroy
    @ride = Relationship.find(params[:id]).ride
    current_user.ungoing(@ride)
    puts @ride
    puts "HERSSSS"
    respond_to do |format|
      format.html { redirect_to rides_url() }
      format.js
    end
  end
end
