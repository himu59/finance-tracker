class UserStocksController < ApplicationController

    def create
        stock = Stock.check_db(params[:ticker])

        if stock
            flash[:notice] = "Stock is already present in your portfolio"
        end
        if stock.nil? #if doesnt exit we get from api call
            stock = Stock.new_lookup(params[:ticker])
            if !stock.nil?
                stock.save
            end   
            @user_stock = UserStock.create(user: current_user, stock: stock)
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
