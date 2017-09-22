module SiteBuilder
  class Client

    module Pages

      def pages
        @pages_proxy ||= PagesProxy.new(self)
      end

      class PagesProxy < SiteBuilder::Client::Resources::Proxy

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
          content = attributes.delete(:content) || attributes.delete('content')
          attributes['string_content'] = content.to_json unless content.nil?
          { 'page' => attributes }
        end

        def path
          raise ResourceNotScopedBySite.new if @site_id.nil?
          "sites/#{@site_id}/pages"
        end

      end

    end

  end
end
