class RidesController < ApplicationController
  before_action :user?,      only: [:edit, :update, :destroy, :new, :create, :index]
  before_action :admin_user,      only: [:edit, :update, :destroy, :new, :create]

  def index
    @rides_feed = Ride.all
  end

  def create
    @ride = current_user.rides.build(ride_params)
    if @ride.save
      flash[:success] = "Ride created!"
      redirect_to root_url
    else
      @feed_items = []
      flash[:error] = @ride.errors.full_messages
      if user_signed_in?
        render 'new'
      else
        render 'static_pages/home'
      end
    end
  end

  def new
    @ride = current_user.rides.build
  end

  def destroy
    Ride.find(params[:id]).destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  def edit
    @ride = Ride.find(params[:id])
  end

  def update
    @ride = Ride.find(params[:id])
    if @ride.update_attributes(ride_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def ride_params
      valid = params.require(:ride).permit(:content, :title, :meet_at, :start_at, :end_at)
      return valid
    end
end
