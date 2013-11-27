require 'open-uri'

class ParserFactory
  class << self
    def get_parser page
      link = page.link
      url = page.origin

      if link.news_source.to_sym == :protv
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
      begin
        source.to_s.camelize.constantize::Parser.new(page)
      rescue Exception => e
        puts "could not load parser for #{source} because #{e}"
      end
    end
  end
end
