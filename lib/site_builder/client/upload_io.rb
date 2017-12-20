require 'faraday'
require 'mime/types'

module SiteBuilder
  class Client

    class UploadIO < ::Faraday::UploadIO

      def initialize(filename_or_io, content_type = nil, filename = nil)
        super(filename_or_io, content_type || 'application/octet-stream', filename)
      end

    end

    class ImageUploadIO < ::Faraday::UploadIO

      def initialize(filename_or_io, content_type = nil, filename = nil)
        content_type ||= MIME::Types.type_for(filename_or_io).first
        super(filename_or_io, content_type, filename)
      end

    end

  end

end
