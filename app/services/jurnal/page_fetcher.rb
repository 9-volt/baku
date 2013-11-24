class Jurnal::PageFetcher < PageFetcher
  def valid?(page_data)
    /The page you are looking for is not found./i !~ page_data
  end
end
