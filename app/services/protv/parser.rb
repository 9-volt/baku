class Protv::Parser < Parser
  def parse_time
    Time.parse doc.css('div[itemprop=datePublished]').first[:content]
  end

  def parse_category
    doc.css('ul.breadcrumbs li').last.text.downcase.squish
  end

  def parse_author
    doc.css('.article_source_url').first.text
  end

  def parse_sentences
    doc.css('.articleContent p').children.map(&:text).map {|s| s.split(/[\.!?]/)}
    .flatten.map(&:strip).select {|s| s.size > 1 }
  end

  def parse_title
    doc.css('title').text
  end
end
