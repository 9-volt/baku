require 'spec_helper'

describe Link do
  context ".from_source" do
    let!(:unimedia_link) { FactoryGirl.create(:link, news_source: :unimedia) }
    let!(:jurnal_link)   { FactoryGirl.create(:link, news_source: :jurnal) }

    it "returns only the links from the source" do
      Link.from_source(:unimedia).count.should == 1
    end
  end

  context ".one_unparsed" do
    let!(:unimedia_link) { FactoryGirl.create(:link, news_source: :unimedia) }

    it "returns the link" do
      Link.one_unparsed.should == unimedia_link
    end
  end
end
