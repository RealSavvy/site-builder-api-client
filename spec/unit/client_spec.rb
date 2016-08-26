require 'spec_helper'

describe SiteBuilder::Client do

  let(:options) { { email: 'john@doe.net', api_key: '42' } }
  let(:client)  { SiteBuilder::Client.new(options) }

  describe '#options' do

    subject { client.options }

    it { expect(subject[:uri].to_s).to eq 'https://builder.locomotivecms.com/api' }

  end

end
