require 'factory_girl'

FactoryGirl.define do
  factory :link do
    url         'http://unimedia.info/stiri/permalink-68152.html'
    news_source :unimedia
    parsed_at   Time.now
    success     false
    attempted   false
  end
end