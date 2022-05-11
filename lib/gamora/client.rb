# frozen_string_literal: true

module Gamora
  class Client < OAuth2::Client
    def self.from_config
      new(
        Configuration.client_id,
        Configuration.client_secret,
        {
          site: Configuration.site,
          token_url: Configuration.token_url,
          token_method: Configuration.token_method,
          redirect_uri: Configuration.redirect_uri,
          authorize_url: Configuration.authorize_url,
          introspect_url: Configuration.introspect_url
        }
      )
    end

    def access_token_active?(access_token)
      response = verify_access_token_request(access_token)
      data = JSON.parse(response.body).symbolize_keys
      !!data[:active]
    end

    private

    def verify_access_token_request(access_token)
      opts = verify_access_token_options(access_token)
      request(:post, options[:introspect_url], opts)
    end

    def verify_access_token_options(access_token)
      {
        body: verify_access_token_params(access_token),
        headers: verify_access_token_headers
      }
    end

    def verify_access_token_params(access_token)
      {
        client_id: id,
        client_secret: secret,
        token: access_token
      }.to_json
    end

    def verify_access_token_headers
      { "Content-Type": "application/json" }
    end
  end
end
