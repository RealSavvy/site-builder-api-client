require 'spec_helper'

describe SiteBuilder::Client::UploadIO do

  let(:path) { File.join(File.dirname(__FILE__), '..', 'fixtures', 'logo.png') }

  subject { SiteBuilder::Client::UploadIO.new(path) }

  it { is_expected.not_to be nil }

end
