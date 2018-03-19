module SiteBuilder
  class Client

    module Assets

      def assets
        @assets_proxy ||= AssetsProxy.new(self)
      end

      class AssetsProxy < SiteBuilder::Client::Resources::Proxy

        def scope_by(site)
          @site_id = site.respond_to?(:id) ? site.id : site
        end

        def all(params = {})
          paginate(path, params)
        end

        def create(attributes = {})
          response = post(path, attributes_for_request(attributes))
          build(response['data'])
        end

        def destroy(id)
          response = delete("#{path}/#{id}")
          build(response['data'])
        end

        private

        def attributes_for_request(attributes)
          { 'asset' => attributes }
        end

        def path
          raise ResourceNotScopedBySite.new if @site_id.nil?
          "sites/#{@site_id}/assets"
        end

      end

    end

  end
end
