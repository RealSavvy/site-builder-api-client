module SiteBuilder
  class Client

    module Resources

      def build(data)
        Resource.new(data)
      end

      class Resource

        def initialize(data)
          @data = data
        end

        def id
          @data['id']
        end

        def attributes
          @data['attributes']
        end

        def method_missing(name, *args)
          if self.attributes.key?(name.to_s)
            self.attributes[name.to_s]
          else
            super
          end
        end

        def respond_to?(name, include_private = false)
          self.attributes.key?(name.to_s) || super
        end

      end

      class Proxy

        attr_reader :client

        extend Forwardable

        def_delegators :client, :get, :put, :post, :delete

        def initialize(client)
          @client = client
        end

        def paginate(path, params, &block)
          Enumerator.new do |y|
            loop do
              response = client.get(path, params)

              response['data'].each do |data|
                y.yield client.build(data)
              end

              break if response['links']['next'].nil?

              # setup the next page
              params[:page] ||= { number: 1, size: 10 }
              params[:page][:number] += 1
            end
          end
        end

        def build(data)
          SiteBuilder::Client::Resource.new(data)
        end

      end

    end

  end
end
