# SiteBuilder Ruby Client

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'site_builder_client', git: 'https://gitlab.com/locomotivecms-enterprise-public/ruby-api-client.git'
```

And then execute:

    $ bundle

## Usage

First, create your client session:

```ruby
client = SiteBuilder::Client.new(email: '<YOUR EMAIL>', api_key: '<YOUR API KEY')
```

Then, request the resources you need to:

```ruby
client.accounts.list.each do |account|
  puts "#{account.email} [#{account.id}]"
end

client.accounts.list.each do |account|
  puts "#{account.email} [#{account.id}]"
end

account = client.accounts.create(name: 'John Doe', email: 'john@doe.net', role: 'site_owner', password: 'simplepassword', password_confirmation: 'simplepassword')
```

## All Resources and actions

### Account resource

```ruby
client = SiteBuilder::Client.new(email: '<YOUR EMAIL>', api_key: '<YOUR API KEY')
client.accounts
```

* `client.accounts.all`
* `client.accounts.all(filter: { key: value })`
* `client.accounts.find(id)`
* `client.accounts.create({ key: value, ....})`
* `client.accounts.update(id, { key: value, ....})`
* `client.accounts.destroy(id)`


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `site_builder/client_version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://gitlab.com/locomotivecms-enterprise-public/ruby-api-client/issues.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

