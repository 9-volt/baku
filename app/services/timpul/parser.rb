class Timpul::Parser < Parser
  def parse_time
    convert_time metadata[2]
  end

  def parse_author
    author = doc.css('.author')
    if author.text.empty?
      "timpul"
    else
      author.css('.bold').text
    end
  end

  def parse_category
    metadata[1]
  end

  def parse_sentences
    doc.css('.changeFont').text.split(/[\.!?]/).map{|s| s.gsub("\t",'').gsub("\n",'').strip}
  end

  def parse_title
    doc.css('.box.artGallery h1').text.strip
  end

  def metadata
    doc.css('.box.artGallery').css('.data_author').text.split("\n").map(&:strip)
  end

  def convert_time(str)
    match_data = str.match(/(?<day>\d+) (?<month>\S+) (?<year>\d+), ora (?<hours>\d+):(?<minutes>\d+)/)
    Time.new(match_data[:year],
             convert_month(match_data[:month]),
             match_data[:day],
             match_data[:hours],
             match_data[:minutes])
  end

  def convert_month(str)
    case str
      when 'Aprilie'    then 'apr'
      when 'Mai'        then 'may'
      when 'Iunie'      then 'jun'
      when 'Iulie'      then 'jul'
      when 'August'     then 'aug'
      when 'Septembrie' then 'sep'
      when 'Octombrie'  then 'oct'
      when 'Noiembrie'  then 'nov'
      when 'Decembrie'  then 'dec'
      when 'Ianuarie'   then 'jan'
      when 'Februarie'  then 'feb'
      when 'Martie'     then 'mar'
      else str
    end
  end
end