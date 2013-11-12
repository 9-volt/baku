class DashboardPresenter
  attr_reader :users

  def initialize
    @users = User.all
  end
end