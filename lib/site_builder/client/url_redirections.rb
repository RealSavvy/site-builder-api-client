module SiteBuilder
  class Client

    module UrlRedirections

      def url_redirections
        @url_redirections_proxy ||= UrlRedirectionsProxy.new(self)
      end

      class UrlRedirectionsProxy < SiteBuilder::Client::Resources::Proxy

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

        def update(id, attributes = {})
          response = put("#{path}/#{id}", attributes_for_request(attributes))
          build(response['data'])
        end

        def destroy(id)
          response = delete("#{path}/#{id}")
          build(response['data'])
        end

        private

        def attributes_for_request(attributes)
          { 'url_redirection' => attributes }
        end

        def path
          raise ResourceNotScopedBySite.new if @site_id.nil?
          "sites/#{@site_id}/url_redirections"
        end

      end

    end

  end
end
