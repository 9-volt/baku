require 'spec_helper'

describe Unimedia::LinkGenerator do
  let!(:latest_link)  { FactoryGirl.create(:link, source: :unimedia) }
  let(:generator)     { Unimedia::LinkGenerator.new }
  let(:page_stub)     { PageFixtures.load('unimedia_main.html') }
  let(:data)          { generator.fetch }

  context 'when the site returns a valid html page' do
    before do
      RestClient.stub(:get).with(Unimedia::LinkGenerator::MAIN_URL).and_return(page_stub)
    end

    it 'stores the links in the database' do
      expect { generator.fetch }.to change { Link.all.count }.by(4)
    end
  end
end
