require 'uri'

class Protv::LinkGenerator < FbGraphLinkGenerator
  def page_id
    'protvchisinau'
  end

  def extract_url hash
    logger.info "extract url from #{hash['message']}"
    URI.extract(hash["message"]).first
  end

  def valid? link
    return false unless link.start_with? "http"
    return true if link.start_with? "http://go.protv.md"
    false
  end
end