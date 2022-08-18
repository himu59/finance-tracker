class UserStocksController < ApplicationController

    def create
        user_id = params[:user]
        st = Stock.where(ticker: params[:ticker]).first
        stock_id = nil
        if !st.nil?
            stock_id = st.id
        end
        stock = Stock.check_db(stock_id,user_id)
        if !stock.nil?
            flash[:notice] = "Stock is already present in your portfolio"
        end
        if stock.nil? #if doesnt exit we get from api call
            stock = Stock.new_lookup(params[:ticker])
            if !stock.nil?
                stock.save
            end   
            # debugger
            @user_stock = UserStock.create(user_id: user_id, stock_id: stock.id)
            flash[:notice] = "Stock was successfully added to your portfolio"
        end
        redirect_to my_portfolio_path
    end

    def destroy
        # debugger
        stock = Stock.find(params[:format])
        user_stock = UserStock.where(user_id: current_user.id, stock_id: stock).first
        user_stock.destroy
        flash[:notice] = "#{stock.ticker} was successfully removed from your portfolio"
        redirect_to my_portfolio_path
    end
end
