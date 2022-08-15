class Stock < ApplicationRecord

    def self.new_lookup(ticker_symbol) #we dont need to create instance of class to call this method we can directly call 
        client = IEX::Api::Client.new(
            publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
            secret_token: Rails.application.credentials.iex_client[:sandbox_secret_key],
            endpoint: 'https://sandbox.iexapis.com/v1'
        )
        return client.price(ticker_symbol)
    end
end
