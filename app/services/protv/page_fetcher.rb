class Protv::PageFetcher < PageFetcher
  def valid?(page_data)
    /Pagina pe care ati incercat sa o accesati nu exista sau a fost relocata/i !~ page_data
  end
end
