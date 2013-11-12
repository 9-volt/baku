class SummaryMailer < ActionMailer::Base
  default from: "mailer@9vo.lt"

  def summary(user_id)
    @total_attempts = Link.recently_updated.count
    @parsed_links   = Link.recently_updated.successful.count
    @by_source      = Link.recently_updated.by_source

    mail(to: address(user_id), subject: '9vo.lt daily parsing summary')
  end

  def updated_status(user_id, count)
    @count = count

    mail(to: address(user_id), subject: 'Welcome to My Awesome Site')
  end

private

  def address(user_id)
    User.find(user_id).email
  end
end
