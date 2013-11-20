class DashboardController < ApplicationController
  before_filter :authenticate_user!
  layout 'inside'

  def index
    @presenter = DashboardPresenter.new
  end
end
