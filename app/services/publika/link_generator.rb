require 'uri'

class Publika::LinkGenerator < FbGraphLinkGenerator
  def page_id
    'Publika.md'
  end

  def source
    :publika
  end

  def valid? link
    return false unless link.start_with? "http"
    return true if link.start_with? "http://www.publika"
    false
  end
end