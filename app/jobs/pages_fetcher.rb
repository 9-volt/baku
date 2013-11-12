class PagesFetcher
  include Sidekiq::Worker

  def perform
    link = Link.one_unparsed
    if link.source == :unimedia
      Unimedia::PageFetcher.new(link).fetch!
    end
  end
end