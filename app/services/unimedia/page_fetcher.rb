class Unimedia::PageFetcher
  attr_reader :link

  def initialize(link)
    logger.info "Starting to parse #{link.url}"
    @link = link
  end

  def fetch!
    page_data = RestClient.get(link.url)

    link.update_attributes!(attempted: true)

    if valid? page_data
      logger.info "Page data valid, saving page"
      Page.create!(link: link, content: page_data)
      link.update_attributes!(success: true)
      link.update_attributes!(parsed_at: Time.now)
    else
      logger.info "Page data invalid, cannot saving page"
      link.update_attributes!(success: false)
    end
  end
private
  def valid?(page_data)
    /Ne pare rău, pagina nu a fost găsită./ !~ page_data
  end

  def logger
    Rails.logger
  end
end