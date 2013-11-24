require 'uri'

class Timpul::LinkGenerator < FbGraphLinkGenerator
  def page_id
    'Timpul.md'
  end

  def source
    :timpul
  end

  def valid? link
    return false unless link.start_with? "http"
    return true if link.start_with? "http://www.timpul"
    false
  end
end