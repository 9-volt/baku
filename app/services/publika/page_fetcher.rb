class Publika::PageFetcher < PageFetcher
  def valid?(page_data)
    Nokogiri::HTML(page_data).css('.articleInfo').any?
  end
end
