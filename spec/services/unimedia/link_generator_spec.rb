require 'spec_helper'

describe Unimedia::LinkGenerator do
  let(:generator)     { Unimedia::LinkGenerator.new }
  let(:page_stub)     { PageFixtures.load('unimedia_main.html') }
  let(:data)          { generator.fetch }

  before do
    RestClient.stub(:get).with(Unimedia::LinkGenerator::MAIN_URL).and_return(page_stub)
  end

  context 'when there are some links in the database' do
    let!(:latest_link)  { FactoryGirl.create(:link, source: :unimedia) }

    it 'stores the links in the database' do
      expect { generator.fetch }.to change { Link.all.count }.by(4)
    end
  end

  context 'when there are no links' do
    it 'generates the default permalink' do
      Link.count.should == 0
      generator.fetch
      Link.count.should be > 10000
    end
  end
end
