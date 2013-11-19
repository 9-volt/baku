class PagesFetcher
  include Sidekiq::Worker

  def perform
    link = Link.one_unparsed
    if link.news_source == "unimedia"
      Unimedia::PageFetcher.new(link).fetch!
    end
  end
end
