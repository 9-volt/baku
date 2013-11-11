require 'spec_helper'

describe Unimedia::LinkGenerator do
  let!(:latest_link)  { FactoryGirl.create(:link, source: :unimedia) }
  let(:generator)     { Unimedia::LinkGenerator.new }
  let(:page_stub)     { PageFixtures.load('unimedia_main') }
  let(:data)          { generator.fetch_new }

  context 'when the site returns a valid html page' do
    before do
      RestApi.stub(:get).with(Unimedia::MAIN_URL).and_return(page_stub)
    end

    it 'returns the correct number of links' do
      expect(data.count).to_eql 10
    end

    it 'stores the links in the database' do
      expect(generator.fetch_new).to_change { Link.all.count }.by(10)
    end
  end
end
