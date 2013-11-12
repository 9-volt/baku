require 'spec_helper'

describe Unimedia::PageFetcher do
  let!(:link) { FactoryGirl.create(:link, source: :unimedia) }

  subject { Unimedia::PageFetcher.new(link.id) }

  before do
    RestClient.stub(:get).with(link.url).and_return(page_content)
  end

  context "when the page is valid" do
  let(:page_content) { PageFixtures.load('unimedia_page_68152.html') }
    it 'fetches the page from the URL and marks the link' do
      subject.fetch!
      Page.count.should == 1
      Page.last.link.should == link
      Page.last.content.should == page_content

      link.reload.attempted.should  == true
      link.reload.success.should    == true
      link.reload.parsed_at.should_not be_nil
    end
  end

  context "with a 404 page" do
    let(:page_content) { PageFixtures.load('unimedia_404.html') }
    it 'does not save the page' do
      subject.fetch!
      Page.count.should == 0

      link.reload.attempted.should == true
      link.success.should == false
    end
  end
end