require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Darkscience < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'https://auth.darkscience.net',
        :authorize_url => 'https://auth.darkscience.net/oauth/auth',
        :token_url => 'https://auth.darkscience.net/oauth/access_token'
      }

      def request_phase
        super
      end

      def authorize_params
        super.tap do |params|
          %w[scope client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

      uid { raw_info['id'].to_s }

      info do
        {
          'nickname' => raw_info['account_name'],
          'email' =>  raw_info['email'],
          'name' => raw_info['name'],
          'image' => raw_info['avatar'],
        }
      end

      extra do
        {:raw_info => raw_info}
      end

      def raw_info
        access_token.options[:mode] = :query
        @raw_info ||= access_token.get('user').parsed
      end

    end
  end
end

OmniAuth.config.add_camelization 'darkscience', 'Darkscience'
