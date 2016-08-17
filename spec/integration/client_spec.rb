require 'spec_helper'

describe SiteBuilder::Client do

  before { VCR.insert_cassette 'client', record: :new_episodes, match_requests_on: [:method, :query, :body] }
  after  { VCR.eject_cassette }

  let(:uri)         { 'http://app.locomotivesitebuilder.dev:5000/' }
  let(:connection)  { { uri: uri, email: 'vcr@locomotivecms.com', api_key: '2835773401765d36050f88f1307d721dcec6bc3a' } }
  let(:instance)    { described_class.new(connection) }

  describe '#token' do

    subject { instance.token }

    it { is_expected.not_to eq nil }

  end

  describe '#accounts' do

    describe '#list' do

      subject { instance.accounts.list }

      it { is_expected.not_to eq [] }
      it { expect(subject.first.email).not_to eq nil }

    end

    describe '#find' do

      let(:account_id) { 7 }

      subject { instance.accounts.find(account_id) }

      it { is_expected.not_to eq nil }

      context 'the id does not exist' do

        let(:account_id) { 42 }

        it { is_expected.to eq nil }

      end

    end

    describe '#create' do

      let(:attributes) { { name: 'John #1', email: 'john-1@doe.net', role: 'site_owner', password: 'test31', password_confirmation: 'test31' } }

      subject { instance.accounts.create(attributes) }

      it { expect(subject.id).not_to eq nil }

      context 'no attributes' do

        let(:attributes) { {} }

        it { expect { subject }.to raise_error(SiteBuilder::Client::InvalidResourceError) }

      end

      context 'missing attributes' do

        let(:attributes) { { name: 'John #2' } }

        it { expect { subject }.to raise_error(SiteBuilder::Client::InvalidResourceError) }

      end

    end

    describe '#update' do

      subject { instance.accounts.update(7, name: 'John Doe #1') }

      it { expect(subject.name).to eq 'John Doe #1' }

    end

    describe '#destroy' do

      subject { instance.accounts.destroy(7) }

      it { expect(subject.id).not_to eq nil }

    end

  end

end
