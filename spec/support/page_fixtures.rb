module PageFixtures
  FIXTURE_PATH = Rails.root.join("spec/fixtures")

  def self.load(page_name)
    File.read(FIXTURE_PATH + page_name)
  end
end