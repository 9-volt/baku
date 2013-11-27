require 'open-uri'

class PageFetcher
  attr_reader :link

  def initialize(link)
    logger.info "Starting to fetch #{link.url}"
    @link = link
  end

  def valid?(page_data)
    true #implement that in subclass
  end

  def fetch!
    link.update_attributes!(attempted: true)

    open(link.url) do |resp|
      origin = resp.base_uri.to_s
      data = resp.read
      process origin, data
    end
  end

private

  def process origin, data
    if valid? data
      logger.info "Page data valid, saving page"
      page = link.build_page(content: data, origin: origin)
      page.save!
      link.update_attributes!(success: true)
      link.update_attributes!(fetched_at: Time.now)
      page
    else
      logger.info "Page data invalid, cannot saving page"
      link.update_attributes!(success: false)
    end
  end

  def logger
    Rails.logger
  end
end
