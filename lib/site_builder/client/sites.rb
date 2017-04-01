module SiteBuilder
  class Client

    module Sites

      def sites
        @sites_proxy ||= SitesProxy.new(self)
      end

      class SitesProxy < SiteBuilder::Client::Resources::Proxy

        def all(params = {})
          paginate('sites', params)
        end

        def create(attributes = {})
          response = post('sites', attributes_for_request(attributes))
          build(response['data'])
        end

        def update(id, attributes = {})
          response = put("sites/#{id}", attributes_for_request(attributes))
          build(response['data'])
        end

        def destroy(id)
          response = delete("sites/#{id}")
          build(response['data'])
        end

        # actions scoped by a site

        def update_pickers(id, resource_type, resource_id, resource)
          response = put("sites/#{id}/pickers/update_all", {
            resource_type:  resource_type,
            resource_id:    resource_id,
            resource:       resource
          })
          build(response['data'])
        end

        private

        def attributes_for_request(attributes)
          {
            'owner_id'  => attributes.delete(:owner_id),
            'theme_id'  => attributes.delete(:theme_id),
            'site'      => attributes
          }
        end

      end

    end

  end
end
