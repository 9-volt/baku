class PageFetcher
  attr_reader :link

  def initialize(link)
    logger.info "Starting to parse #{link.url}"
    @link = link
  end

  def valid?(page_data)
    true #implement that in subclass
  end

  def fetch!
    page_data = RestClient.get(link.url)
    link.update_attributes!(attempted: true)

    if valid? page_data
      logger.info "Page data valid, saving page"
      Page.create!(link: link, content: page_data)
      link.update_attributes!(success: true)
      link.update_attributes!(fetched_at: Time.now)
    else
      logger.info "Page data invalid, cannot saving page"
      link.update_attributes!(success: false)
    end
  end

private

  def logger
    Rails.logger
  end
end