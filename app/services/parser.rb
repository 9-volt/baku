class Parser
  attr_reader :doc
  def initialize html
    @doc = Nokogiri::HTML(html)
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

  [:author, :category, :time, :title, :sentences].each do |data|
    define_method "parse_#{data}" do
      raise ArgumentError.new "you need to define parse_#{data} in subclass"
    end
  end
end