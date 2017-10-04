require 'spec_helper'

describe SiteBuilder::Client do

  before { VCR.insert_cassette 'content_entries', record: :new_episodes, match_requests_on: [:method, :query, :body] }
  after  { VCR.eject_cassette }

  let(:site_id)     { 119 }
  let(:uri)         { 'http://app.locomotivesitebuilder.dev:5000/' }
  let(:connection)  { { uri: uri, email: 'rspec@nocoffee.fr', api_key: 'a16f0cb36b8b86f6f8abe3ab535b79eb52242e37' } }
  let(:instance)    { described_class.new(connection) }

  describe '#content_entries' do

    before { instance.content_entries.scope_by(site_id, 'team') }

    describe '#all' do

      subject { instance.content_entries.all }

      it { is_expected.not_to eq [] }
      it { expect(subject.first.attributes['slug']).not_to eq nil }

    end

    describe '#create' do

      subject { instance.content_entries.create(content: {
        fullname: 'Jane Doe',
        title:    'CFO'
      }) }

      it { expect(subject.attributes['slug']).to eq 'jane-doe' }

    end

    describe '#destroy' do

      subject { instance.content_entries.destroy(30) }

      it { expect(subject.id).not_to eq nil }

    end

  end

end
