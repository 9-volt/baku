class Parser
  attr_reader :doc, :url
  def initialize page
    @url = page.origin
    @doc = Nokogiri::HTML(page.content)
  end

  def parse
    {
      author: parse_author,
      category: parse_category,
      time: parse_time,
      title: parse_title,
      sentences: parse_sentences
    }
  end

  def parse_title
    doc.css('title').text
  end

  [:author, :category, :time, :sentences].each do |data|
    define_method "parse_#{data}" do
      raise ArgumentError.new "you need to define parse_#{data} in subclass"
    end
  end

private

  def extract_sentences text
    text.split(/[\.!?]/).map(&:squish).select {|s| s.size > 1}
  end
end
