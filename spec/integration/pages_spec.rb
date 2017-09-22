require 'spec_helper'

describe SiteBuilder::Client do

  before { VCR.insert_cassette 'pages', record: :new_episodes, match_requests_on: [:method, :query, :body] }
  after  { VCR.eject_cassette }

  let(:uri)         { 'http://app.locomotivesitebuilder.dev:5000/' }
  let(:connection)  { { uri: uri, email: 'vcr@locomotivecms.com', api_key: 'e4b33e8050bcf6d721ef8a472b1986bc8eaa9352' } }
  let(:instance)    { described_class.new(connection) }

  describe '#pages' do

    before { instance.pages.scope_by(5) }

    describe '#all' do

      subject { instance.pages.all }

      it { is_expected.not_to eq [] }
      it { expect(subject.first.title).not_to eq nil }

    end

    describe '#create' do

      subject { instance.pages.create(title: 'My new page', content: {
        blocks: [
          { 'type' => 'call_to_action', 'content' => {
            'text' => 'Hello world',
            'link' => { 'url' => '/', 'label' => 'Visit' },
            'action' => { 'url' => '/', 'label' => 'Go!' }
          } }
        ]
      }) }

      it { expect(subject.title).to eq 'My new page' }

    end

    describe '#update' do

      subject { instance.pages.update(295, title: 'Another page!') }

      it { expect(subject.title).to eq 'Another page!' }

    end

    describe '#destroy' do

      subject { instance.pages.destroy(298) }

      it { expect(subject.id).not_to eq nil }

    end

  end

end
