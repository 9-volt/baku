class Unimedia::PageFetcher < PageFetcher
  def valid?(page_data)
    /ne pare .+ nu a fost/i !~ page_data
  end
end
