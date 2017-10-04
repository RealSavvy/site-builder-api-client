module SiteBuilder

  class Client

    PLATFORM_API = ENV['SITE_BUILDER_PLATFORM_API'] || 'https://builder.locomotivecms.com'

    require_relative './client/resources'
    Dir[File.expand_path('../client/*.rb', __FILE__)].each { |f| require f }

    include SiteBuilder::Client::Request
    include SiteBuilder::Client::Resources
    include SiteBuilder::Client::Token
    include SiteBuilder::Client::Accounts
    include SiteBuilder::Client::Themes
    include SiteBuilder::Client::Sites
    include SiteBuilder::Client::Pages
    include SiteBuilder::Client::BlogPosts
    include SiteBuilder::Client::ContentEntries

    attr_reader :options

    def initialize(options)
      @options = options
      @options[:uri] = prepare_uri(options[:uri] || PLATFORM_API)
    end

    private

    def ssl?
      !!options[:ssl]
    end

    def uri_path
      [options[:path_prefix], 'api'].compact.join('/')
    end

    def prepare_uri(str)
      str = "http://#{str.to_s}" unless str.to_s =~ /^https?:\/\//

      URI(str).tap do |uri|
        if ssl?
          uri.scheme  = 'https'
          uri.port    = 443 if uri.port = 80
        end

        if uri.path == '/' || uri.path.nil? || uri.path == ''
          uri.merge!(uri_path)
        end
      end
    end

  end

end
