class Unimedia::PageFetcher
  attr_reader :link

  def initialize(link_id)
    @link = Link.find(link_id)
  end

  def fetch!
    page_data = RestClient.get(link.url)

    link.update_attributes!(attempted: true)

    if valid? page_data
      Page.create!(link: link, content: page_data)
      link.update_attributes!(success: true)
      link.update_attributes!(parsed_at: Time.now)
    else
      link.update_attributes!(success: false)
    end
  end
private
  def valid?(page_data)
    /Ne pare rău, pagina nu a fost găsită./ !~ page_data
  end
end