require 'spec_helper'

describe SiteBuilder::Client do

  before { VCR.insert_cassette 'sites', record: :new_episodes, match_requests_on: [:method, :query, :body] }
  after  { VCR.eject_cassette }

  let(:uri)         { 'http://app.locomotivesitebuilder.dev:5000/' }
  let(:connection)  { { uri: uri, email: 'vcr@locomotivecms.com', api_key: '2835773401765d36050f88f1307d721dcec6bc3a' } }
  let(:instance)    { described_class.new(connection) }

  describe '#sites' do

    describe '#all' do

      subject { instance.sites.all }

      it { is_expected.not_to eq [] }
      it { expect(subject.first.name).not_to eq nil }

    end

    describe '#create' do

      subject { instance.sites.create(name: 'Effilab Site #1', handle: 'effilab-site-1', theme_id: 8, owner_id: 11) }

      it { expect(subject.name).to eq 'Effilab Site #1' }

    end

    describe '#update' do

      subject { instance.sites.update(2, name: 'Effilab Site #1!') }

      it { expect(subject.name).to eq 'Effilab Site #1!' }

    end

    describe '#destroy' do

      subject { instance.sites.destroy(2) }

      it { expect(subject.id).not_to eq nil }

    end

  end

end
