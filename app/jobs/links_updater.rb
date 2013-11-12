class LinksUpdater
  include Sidekiq::Worker

  def perform
    @count_before = Link.where(source: :unimedia).count
    Unimedia::LinkGenerator.new.fetch
    notify
  end

  def notify
    updated_count = Link.count - @count_before

    User.all.each do |user|
      SummaryMailer.delay.updated_status(user.id, updated_count)
    end
  end
end