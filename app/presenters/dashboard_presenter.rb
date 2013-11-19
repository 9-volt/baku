class DashboardPresenter
  attr_reader :users, :updated_today

  def initialize
    @users = User.all
    @updated_today = Link.recently_updated.from_source(:unimedia).successful.count
  end
end
