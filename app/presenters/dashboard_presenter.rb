class DashboardPresenter
  attr_reader :users, :updated_unimedia

  def initialize
    @users = User.all
    @updated_unimedia = Link.recently_updated.from_source(:unimedia).successful.count
  end
end
