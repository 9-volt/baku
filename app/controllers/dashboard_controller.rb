class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @presenter = DashboardPresenter.new
  end
end