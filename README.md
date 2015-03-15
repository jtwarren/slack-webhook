# Slack Webhook Gem

A simple ruby gem for getting functionality out of Slack's webhooks.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slack-webhook'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install slack

## Usage

```ruby
Slack.configure do |config|
  config.channel = '#engineering' # or '@jeff'
  config.icon_emoji = ':ghost:'
  config.url = 'https://hooks.slack.com/services/id_1/id_2/token'
  config.username = 'deploybot'
end
```

Example usage in capistrano to notify deployments

```ruby
task :notify_start do
  if ['production', 'staging'].include?(fetch(:rails_env))
    Slack.post("Starting deployment of `#{fetch(:branch)}` to `#{fetch(:rails_env)}`")
  end
end
```
