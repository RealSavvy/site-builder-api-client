module SiteBuilder

  class Client

    class Error < StandardError

      attr_reader :response

      def initialize(response = nil)
        @response = response
        super(build_message)
      end

      def body
        @response.body || {}
      end

      def self.from_response(response)
        status = response.status
        if klass = case status.to_i
                    when 401      then SiteBuilder::Client::UnauthorizedError
                    when 404      then SiteBuilder::Client::UnknownResourceError
                    when 413      then SiteBuilder::Client::FileTooBigError
                    when 422      then SiteBuilder::Client::InvalidResourceError
                    when 429      then SiteBuilder::Client::TooManyRequestsError
                    when 500      then SiteBuilder::Client::ServerSideError
                    else Error
                    end
          klass.new(response)
        end
      end

      private

      def build_message
        @response ? (body['error'] || body['message']) : nil
      end

    end

    class MissingURIOrCredentialsError < StandardError; end
    class BadRequestError < StandardError; end
    class UnknownResourceError < Error; end
    class TooManyRequestsError < Error; end
    class UnauthorizedError < Error; end
    class ServerSideError < Error; end
    class TimeoutError < Error; end

    class ResourceNotScopedBySite < Error; end

    class FileTooBigError < Error

      private

      def build_message
        'File too big for the server'
      end

    end

    class InvalidResourceError < Error

      private

      def build_message
        case errors = body['errors']
        when String then errors
        when Array then
          errors.map do |error|
            "#{error['source']['pointer']} #{error['detail']}"
          end
        else
          body['message']
        end
      end

    end

  end
end
