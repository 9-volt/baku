require 'open-uri'

class ParserFactory
  class << self
    def get_parser page
      link = page.link

      puts link.news_source

      if link.news_source.to_sym == :protv
        url = expand link.url

        if url.start_with? "http://perfecte.md"
          source = :perfecte
        elsif url.start_with? "http://www.inprofunzime"
          source = :inprofunzime
        elsif url.start_with? "http://acasatv"
          source = :acasatv
        else
          source = :protv
        end

        load source, page
      else
        load link.news_source, page
      end
    end

  private

    def load source, page
      puts source
      puts page.link.url
      begin
        source.to_s.camelize.constantize::Parser.new(page)
      rescue Exception => e
        puts "could not load parser for #{source} because #{e}"
      end
    end

    def expand url
      result = url

      if url.start_with? "http://bit.ly"
        open(url) do |resp|
          result = resp.base_uri.to_s
        end
      end

      result
    end
  end
end