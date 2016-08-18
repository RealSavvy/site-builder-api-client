require 'spec_helper'

describe SiteBuilder::Client do

  before { VCR.insert_cassette 'themes', record: :new_episodes, match_requests_on: [:method, :query, :body] }
  after  { VCR.eject_cassette }

  let(:uri)         { 'http://app.locomotivesitebuilder.dev:5000/' }
  let(:connection)  { { uri: uri, email: 'vcr@locomotivecms.com', api_key: '2835773401765d36050f88f1307d721dcec6bc3a' } }
  let(:instance)    { described_class.new(connection) }

  describe '#themes' do

    describe '#all' do

      subject { instance.themes.all }

      it { is_expected.not_to eq [] }
      it { expect(subject.first.name).not_to eq nil }

    end

    describe '#update' do

      subject { instance.themes.update(5, name: 'Effilab') }

      it { expect(subject.name).to eq 'Effilab' }

    end

    describe '#destroy' do

      subject { instance.themes.destroy(6) }

      it { expect(subject.id).not_to eq nil }

    end

  end

end
