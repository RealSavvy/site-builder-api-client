module SiteBuilder
  class Client

    module Themes

      def themes
        @themes_proxy ||= ThemesProxy.new(self)
      end

      class ThemesProxy < SiteBuilder::Client::Resources::Proxy

        def all(params = {})
          paginate('themes', params)
        end

        def create(attributes = {})
          update(nil, attributes)
        end

        def update(id_or_handle, attributes = {})
          response = put("themes/#{id_or_handle}", 'theme' => attributes)
          build(response['data'])
        end

        def destroy(id_or_handle)
          response = delete("themes/#{id_or_handle}")
          build(response['data'])
        end

      end

    end

  end
end
