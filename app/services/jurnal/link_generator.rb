require 'uri'

class Jurnal::LinkGenerator < FbGraphLinkGenerator
  def page_id
    'jurnalmd'
  end

  def source
    :jurnal
  end

  def valid? link
    return false unless link.start_with? "http"
    return true if link.start_with? "http://www.jurnal.md"
    false
  end
end