class FbGraphLinkGenerator
  APP_ID = ENV['FACEBOOK_APP_ID']
  APP_SECRET = ENV['FACEBOOK_APP_SECRET']
  DELAY = 5

  attr_reader :api
  def initialize
    oauth = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET)
    token = oauth.get_app_access_token
    @api = Koala::Facebook::API.new(token)
  end

  def page_id
    raise ArgumentError.new "you need to define that in subclass"
  end

  def fetch
    process get_page
  end

  def valid? link
    true
  end

  def extract_url post_hash
    post_hash["link"]
  end

private

  def get_page
    api.get_connections page_id, "posts", :fields => 'message,link'
  end

  def go_deeper? results, links, duplicates
    return false if results.empty?
    return true if ENV['ALL']
    duplicates != links.size
  end

  def process page
    results = page.map {|e| extract_url(e)}
    links = results.select {|l| valid? l}.compact
    logger.info "results #{results}"
    logger.info "valid links #{links}"

    if links.any?
      existing = Link.where('news_source = ? and url in (?)', :protv, links).count
    else
      existing = 0
    end

    links.each do |l|
      link = Link.where(:news_source => :protv, :url => l).first_or_create!
      logger.info "saved link #{link.inspect}"
    end

    puts "#{results.size} #{links.size} #{existing}"
    if go_deeper? results, links, existing
      sleep DELAY
      logger.info "fetching next page"
      process page.next_page
    end
  end

  def logger
    Rails.logger
  end
end