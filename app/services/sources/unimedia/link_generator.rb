class Unimedia::LinkGenerator
  PERMALINK_REGEX = //

  def fetch
    page = RestApi.get(Unimedia::MAIN_URL)
    current_id = find_current_id(page)
    populate_links(last_id, current_id)
  end

  private

    def last_id
      @last_id ||= Link.where(source: :unimedia)
                       .last
                       .url
                       .match(PERMALINK_REGEX)[:id]
    end

    def populeate_links(from, to)
      from.upto(to) do |permalink_id|
        logger.info("Creating Unimedia link for #{permalink_id}")
        Link.create!(source: :unimedia, url: unimedia_url(permalink_id))
      end
    end

    def find_current_id(page)
      doc = Nokogiri::HTML.new(page)
      39
    end

    def unimedia_url(id)
      "www.unimedia.info/articles/permalink_#{id}"
    end

end
