class Timpul::PageFetcher < PageFetcher
  def valid?(page_data)
   Nokogiri::HTML(page_data).css('body').first.text != 'Not Found'
  end
end
