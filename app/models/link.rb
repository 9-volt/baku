class Link < ActiveRecord::Base
  has_one :page

  scope :recently_updated, -> { where('updated_at > ?', 1.day.ago) }
  scope :successful,       -> { where(success: true) }

  def self.by_source
    group(:news_source).count
  end

  def self.one_unparsed
    where(attempted: false).limit(1)
  end
end
