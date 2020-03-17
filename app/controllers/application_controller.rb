class ApplicationController < ActionController::API
    response = Faraday.post("https://api.telegram.org/bot#{ENV['TIENDA_TOKEN']}/setWebhook", "url=https://tienda-bot.herokuapp.com/#{ENV['TIENDATOKEN']}")
    puts response.body
end
