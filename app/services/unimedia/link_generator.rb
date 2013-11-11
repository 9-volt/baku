class Unimedia::LinkGenerator
  MAIN_URL = 'www.unimedia.info'
  PERMALINK_REGEX = /permalink-(?<id>\d+)/

  def fetch
    page = RestClient.get(MAIN_URL)
    current_id = find_current_id(page)
    populate_links(last_id, current_id)
  end

  private

    def last_id
      @last_id ||= Link.where(source: :unimedia)
                       .last
                       .url
                       .match(PERMALINK_REGEX)[:id].to_i
    end

    def populate_links(from, to)
      from.upto(to) do |permalink_id|
        logger.info("Creating Unimedia link for #{permalink_id}")
        Link.create!(source: :unimedia, url: unimedia_url(permalink_id))
      end
    end

    def find_current_id(page)
      doc = Nokogiri::HTML(page)
      doc.css('a.bigtitle').first   # this is a Nokogiri href
         .attributes["href"].value  # ok, we got the permalink URL
         .match(/\d+/)[0].to_i      # ae, obtain something like 45678
    end

    def unimedia_url(id)
      "www.unimedia.info/stiri/permalink-#{id}"
    end

    def logger
      Rails.logger
    end
end
