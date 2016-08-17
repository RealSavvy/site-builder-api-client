# module SiteBuilder
#   class Client

#     class Collection

#       include Enumerable

#       def initialize(response, page, client)
#         @response   = response
#         @page       = page || { number: 0, size: 10 }
#         @client     = client
#       end

#       def each(&block)
#         if @response['links'] || @response['links']['next']

#         @response['data'].each do |data|
#           yield(Resource.new(data))
#         end
#       end

#     end

#     class Resource

#       def initialize(data)
#         @data = data
#       end

#       def id
#         @data['id']
#       end

#       def attributes
#         @data['attributes']
#       end

#       def method_missing(name, *args)
#         if self.attributes.key?(name.to_s)
#           self.attributes[name.to_s]
#         else
#           super
#         end
#       end

#       def respond_to?(name, include_private = false)
#         self.attributes.key?(name.to_s) || super
#       end

#     end

#   end
# end
