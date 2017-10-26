# SiteBuilder Ruby Client

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'site_builder_client', git: 'https://gitlab.com/locomotivecms-enterprise-public/ruby-api-client.git', branch: 'master'
```

And then execute:

    $ bundle

## Usage

First, create your client session:

```ruby
client = SiteBuilder::Client.new(email: '<YOUR EMAIL>', api_key: '<YOUR API KEY>')
```

Then, request the resources you need to:

```ruby
client.accounts.all.each do |account|
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

**Attributes**:

- name
- email
- password
- password_confirmation
- role [site_owner, content_editor]

### Theme resource

```ruby
client = SiteBuilder::Client.new(email: '<YOUR EMAIL>', api_key: '<YOUR API KEY')
client.themes
```

* `client.themes.all`
* `client.themes.all(filter: { key: value })`
* `client.themes.create({ key: value, ....})`
* `client.themes.update(id, { key: value, ....})`
* `client.themes.destroy(id)`

**Attributes**:

- name
- handle
- description
- position
- definition
- zipfile (SiteBuilder::Client::UploadIO)

**Example**:

```ruby
client.themes.create(zipfile: SiteBuilder::Client::UploadIO.new('<local path of my image>'), definition: <Hash>)
```

### Site resource

```ruby
client = SiteBuilder::Client.new(email: '<YOUR EMAIL>', api_key: '<YOUR API KEY')
client.sites
```

* `client.sites.all`
* `client.sites.all(filter: { key: value })`
* `client.sites.create({ key: value, ....})`
* `client.sites.update(id, { key: value, ....})`
* `client.sites.destroy(id)`

**Attributes**:

- name
- owner_id
- theme_id
- handle
- seo_title
- seo_description
- seo_keywords
- domains (Array)
- metadata (Hash)
- style (Hash)

### Page resource

```ruby
client = SiteBuilder::Client.new(email: '<YOUR EMAIL>', api_key: '<YOUR API KEY')
site = client.sites.all(filter: { handle: 'my-site'}).first
client.pages.scope_by(site)
client.pages
```

* `client.pages.all`
* `client.pages.all(filter: { key: value })`
* `client.pages.create({ key: value, ....})`
* `client.pages.update(id, { key: value, ....})`
* `client.pages.destroy(id)`

**Attributes**:

- title
- slug
- content (Hash)
- seo_title
- seo_keywords
- seo_description
- og_title
- og_type
- og_url
- og_description
- og_image
- remove_og_image
- twitter_title
- twitter_description
- twitter_card
- twitter_site
- twitter_image
- remove_twitter_image

### Blog posts

```ruby
client = SiteBuilder::Client.new(email: '<YOUR EMAIL>', api_key: '<YOUR API KEY')
site = client.sites.all(filter: { handle: 'my-site'}).first
client.blog_posts.scope_by(site)
client.blog_posts
```

* `client.blog_posts.all`
* `client.blog_posts.all(filter: { key: value })`
* `client.blog_posts.create({ key: value, ....})`
* `client.blog_posts.update(id, { key: value, ....})`
* `client.blog_posts.destroy(id)`

**Attributes:**

- title
- slug
- content
- short_content
- author_name
- tag_names
- banner
- remove_banner
- published
- published_at
- seo_title
- seo_keywords
- seo_description
- og_title
- og_type
- og_url
- og_description
- og_image
- remove_og_image
- twitter_title
- twitter_description
- twitter_card
- twitter_site
- twitter_image
- remove_twitter_image

### Content entries

```ruby
client = SiteBuilder::Client.new(email: '<YOUR EMAIL>', api_key: '<YOUR API KEY')
site = client.sites.all(filter: { handle: 'my-site'}).first
client.content_entries.scope_by(site, '<YOUR CONTENT TYPE>')
client.content_entries
```

* `client.content_entries.all`
* `client.content_entries.all(filter: { key: value })`
* `client.content_entries.create({ key: value, .... })`
* `client.content_entries.update(id, { key: value, .... })`
* `client.content_entries.destroy(id)`

**Attributes**:

- slug
- content (Hash)
- visible
- seo_title
- seo_keywords
- seo_description
- og_title
- og_type
- og_url
- og_description
- og_image
- remove_og_image
- twitter_title
- twitter_description
- twitter_card
- twitter_site
- twitter_image
- remove_twitter_image

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `site_builder/client_version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://gitlab.com/locomotivecms-enterprise-public/ruby-api-client/issues.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

