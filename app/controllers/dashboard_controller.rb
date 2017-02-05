class DashboardController < ApplicationController
  def index
    @spot_prices = SpotPrice.order(:price).includes(:availability_zone, :instance_type).paginate(:page => params[:page], :per_page => 100)
  end
end
