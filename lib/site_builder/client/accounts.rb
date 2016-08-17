module SiteBuilder
  class Client

    module Accounts

      def accounts
        @accounts_proxy ||= AccountsProxy.new(self)
      end

      class AccountsProxy < SiteBuilder::Client::Resources::Proxy

        def all(params = {})
          paginate('accounts', params)
        end

        def find(id)
          data = get('accounts', { filter: { id: id } })['data'][0]
          data ? build(data) : nil
        end

        def create(attributes = {})
          response = post('accounts', 'account' => attributes)
          build(response['data'])
        end

        def update(id, attributes = {})
          response = put("accounts/#{id}", 'account' => attributes)
          build(response['data'])
        end

        def destroy(id)
          response = delete("accounts/#{id}")
          build(response['data'])
        end

      end

    end

  end
end
