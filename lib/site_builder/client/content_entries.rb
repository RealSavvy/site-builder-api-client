module SiteBuilder
  class Client

    module ContentEntries

      def content_entries
        @content_entries_proxy ||= ContentEntriesProxy.new(self)
      end

      class ContentEntriesProxy < SiteBuilder::Client::Resources::Proxy

        def scope_by(site, type)
          @site_id  = site.respond_to?(:id) ? site.id : site
          @type     = type
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
          _attributes = attributes.dup
          content = _attributes.delete(:content) || _attributes.delete('content')
          _attributes['content'] = content.to_json unless content.nil?
          { 'content_entry' => _attributes }
        end

        def path
          raise ResourceNotScopedBySite.new if @site_id.nil?
          "sites/#{@site_id}/content_types/#{@type}"
        end

      end

    end

  end
end
