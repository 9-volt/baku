require 'uri'

class Timpul::LinkGenerator < FbGraphLinkGenerator
  def page_id
    'Timpul.md'
  end

  def extract_url hash
    logger.info "extract url from #{hash['message']}"
    begin
      URI.extract(hash["message"]).first || hash["link"]
    rescue
      hash["link"]
    end
  end

  def valid? link
    return false unless link.start_with? "http"
    return true if link.start_with? "http://www.timpul"
    false
  end
end