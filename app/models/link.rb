class Link < ActiveRecord::Base
  has_one :page

  scope :recently_updated, -> { where('updated_at > ?', 1.day.ago) }
  scope :successful,       -> { where(success: true) }
  scope :attempted,        -> { where(attempted: true) }
  scope :from_source,      -> (news_source) { where(news_source: news_source) }

  def self.by_source
    group(:news_source).count
  end

  def self.one_unparsed
    where(attempted: false).limit(100).sample
  end

  def download!
    fetcher = self.news_source.to_s.camelize.constantize::PageFetcher
    fetcher.new(self).fetch!
  end
end
