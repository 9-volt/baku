class Unimedia::PageFetcher < PageFetcher
  def valid?(page_data)
    /Ne pare rău, pagina nu a fost găsită./ !~ page_data
  end
end