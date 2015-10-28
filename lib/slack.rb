require "slack/version"
require 'json'
require 'net/http'
require 'uri'

module Slack

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :channel, :icon_emoji, :url, :username

    def initialize
      @channel = '#general'
      @icon_emoji = ':ghost:'
      @url = ''
      @username = 'slackbot'
    end
  end

  def self.post(message)
    channel = Slack.configuration.channel
    icon_emoji = Slack.configuration.icon_emoji
    url = Slack.configuration.url
    username = Slack.configuration.username

    uri = URI(url)
    req = Net::HTTP::Post.new uri.path

    req.body = {"channel" => channel, "username" => username, "text" => "#{message}", "icon_emoji" => icon_emoji}.to_json

    res = Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.ssl_version = :SSLv3
      http.request req
    end
  end
end

