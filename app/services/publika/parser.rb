class Publika::Parser < Parser
  def parse_time
    date = doc.css('div.articleInfo').text
    exp = /(?<day>\d+)-(?<month>\d+)-(?<year>\d+).*(?<hours>\d+):(?<minutes>\d+)/
    match_date = date.match exp

    Time.new(match_date[:year],
             match_date[:month],
             match_date[:day],
             match_date[:hours],
             match_date[:minutes])
  end

  def parse_author
    doc.css('div.articleInfo').children.css('a').first.text
  end

  def parse_category
    doc.css('div.pageHeader a.active').children.first.content.strip
  end

  def parse_sentences
    doc.css('div#articleLeftColumn p').text.split(/[\.!?]/).map(&:strip)
  end

  def parse_title
    doc.css('div#articleLeftColumn h1').text
  end
end