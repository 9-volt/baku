class Perfecte::Parser < Parser
  def parse_time
    convert_time doc.css('.article-date2').first.text
  end

  def parse_category
    URI(url).path.split('/')[2]
  end

  def convert_time str
    match_data = str.match(/(?<day>\d+) (?<month>\S+) (?<year>\d+)/)
    Time.new(
      match_data[:year],
      convert_month(match_data[:month][0..2].downcase),
      match_data[:day])
  end

  def parse_author
    'perfecte'
  end

  def parse_sentences
    summary = doc.css('.summary').first.text
    text = doc.css('.article-text p').map(&:text)
              .map {|s| extract_sentences(s) }
              .flatten

    extract_sentences(summary) + text
  end

  def convert_month(str)
    case str
    when 'ian' then 'jan'
    when 'mai' then 'may'
    when 'iun' then 'jun'
    when 'iul' then 'jul'
    when 'noi' then 'nov'
    else str
    end
  end
end
