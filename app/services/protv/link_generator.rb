require 'uri'

class Protv::LinkGenerator < FbGraphLinkGenerator
  def page_id
    'protvchisinau'
  end

  def source
    :protv
  end

  def valid? link
    return false unless link.start_with? "http"
    return true if link.start_with? "http://go.protv.md"
    false
  end
end