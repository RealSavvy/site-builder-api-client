module SiteBuilder
  class Client

    module Token

      def token
        @token ||= post('tokens', email: options[:email], api_key: options[:api_key], no_authentication: true)['token']
      end

    end

  end
end
