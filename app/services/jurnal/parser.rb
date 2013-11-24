class Jurnal::Parser < Parser
  def parse_time
    date = doc.css('tr.bg_a1 td.lpadd10 span').text
    time = doc.css('tr.bg_a1 td.rpadd10 span').text

    match_date = date.match(/(?<day>\d+) (?<month>\S+) (?<year>\d+)/)
    match_time = time.match(/(?<hours>\d+):(?<minutes>\d+)/)

    Time.new(match_date[:year],
             match_date[:month],
             match_date[:day],
             match_time[:hours],
             match_time[:minutes])
  end

  def parse_author
    doc.css('span.gray').first.next_sibling.text
  end

  def parse_category
    doc.css('a.menu1.bold').text
  end

  def parse_sentences
    doc.css('#news_block tr td').first.text.split(/[\.!?]/).map(&:strip)
  end

  def parse_title
    doc.css('title').text
  end
end