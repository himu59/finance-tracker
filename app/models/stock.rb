class Stock < ApplicationRecord
    has_many :user_stocks
    has_many :users, through: :user_stocks

    validates :name, :ticker, presence: true

    def self.new_lookup(ticker_symbol) #we dont need to create instance of class to call this method we can directly call 
        client = IEX::Api::Client.new(
            publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
            secret_token: Rails.application.credentials.iex_client[:sandbox_secret_key],
            endpoint: 'https://sandbox.iexapis.com/v1'
        )
        begin 
            return Stock.new( ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol) ) #this will stock object
        rescue => exception
            return nil
        end
    end
    
    def self.check_db(ticker_symbol)
        #return object of stock if it is present in our db
        return where(ticker: ticker_symbol).first
    end
end
