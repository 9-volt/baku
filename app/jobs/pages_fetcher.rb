class PagesFetcher
  include Sidekiq::Worker

  def perform
    link = Link.one_unparsed
    if link.news_source == "unimedia"
      Unimedia::PageFetcher.new(link).fetch!
    end
  end

  def self.parse_a_bunch
    per_minute = 60

    per_minute.times do |i|
      perform_in(i.seconds * 2)
    end
  end
end
