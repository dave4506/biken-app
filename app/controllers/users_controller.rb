class UsersController < ApplicationController
  before_action :user?, only: [:setAdmin, :index, :show]
  before_action :admin_user,      only: [:setAdmin, :index]

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def setAdmin
    user = User.find(params[:id])
    ad = user.admin?
    user.update_attribute :admin, !ad
    flash[:success] = "Admin change!"
    redirect_to request.referrer || root_url
  end

end
