class Unimedia::Parser < Parser
  def parse_time
    metadata_container = doc.css('#content .left-container .news-details .white-v-separator')
    convert_time(metadata_container.children.first.text)
  end

  def parse_author
    element = doc.css('#content .display-block')
    if element
      'unimedia'
    else
      element.text.match(/Autor: (?<author>.+)/)[:author]
    end
  end

  def parse_category
    doc.css('#menu .actived').text
  end

  def parse_sentences
    doc.css('#content .news-text').text.split(/[\.!?]/).map(&:strip)
  end

  def parse_title
    doc.css('#content .bigtitlex2').text
  end

  def convert_time(str)
    # converts the date from the format ora: 11:15, 09 iun 2013
    # into a proper ruby time object

    match_data = str.match(/ora: (?<hours>\d+):(?<minutes>\d+), (?<day>\d+) (?<month>\S+) (?<year>\d+)/)
    Time.new(match_data[:year],
             convert_month(match_data[:month]),
             match_data[:day],
             match_data[:hours],
             match_data[:minutes])
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