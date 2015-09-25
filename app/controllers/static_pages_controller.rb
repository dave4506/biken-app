class StaticPagesController < ApplicationController

  def home
    if user_signed_in?
      redirect_to rides_url()
    end
  end

end
