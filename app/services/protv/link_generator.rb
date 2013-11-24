require 'uri'

class Protv::LinkGenerator < FbGraphLinkGenerator
  def page_id
    'protvchisinau'
  end

  def source
    :protv
  end

  def extract_url hash
    logger.info "extract url from #{hash['message']}"
    begin
      URI.extract(hash["message"]).last || hash["link"]
    rescue
      hash["link"]
    end
  end

  def valid? link
    return false unless link.start_with? "http"
    return true if link.start_with? "http://go.protv.md"
    return true if link.start_with? "http://bit.ly"
    false
  end
end