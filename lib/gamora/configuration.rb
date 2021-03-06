# frozen_string_literal: true

module Gamora
  module Configuration
    mattr_accessor :client_id, default: nil
    mattr_accessor :client_secret, default: nil
    mattr_accessor :site, default: nil
    mattr_accessor :token_url, default: "/oauth2/token"
    mattr_accessor :authorize_url, default: "/oauth2/authorize"
    mattr_accessor :userinfo_url, default: "/oauth2/userinfo"
    mattr_accessor :token_method, default: :post
    mattr_accessor :redirect_uri, default: nil
    mattr_accessor :default_scope, default: "openid profile email"
    mattr_accessor :default_prompt, default: nil
    mattr_accessor :default_strategy, default: "default"
    mattr_accessor :ui_locales, default: -> { I18n.locale }

    def setup
      yield(self) if block_given?
    end
  end
end
