class UsersController < ApplicationController

  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_portfolio_update
    err_messages = []
    @tracked_stocks = current_user.stocks
    @tracked_stocks.each do |stock|
        new_stock = Stock.new_lookup(stock.ticker)
        if new_stock
            if new_stock.last_price != stock.last_price
                stock.last_price = new_stock.last_price
            end
            if stock.save
                err_messages << "#{stock.ticker}: Updated"
            else
                err_messages << "#{stock.ticker}: DatabaseErr"
            end
        else
            err_messages << "#{stock.ticker}: ConectionErr"
        end
    end
    flash[:notice] = err_messages.join(", ")
    redirect_to my_portfolio_path
  end
end
