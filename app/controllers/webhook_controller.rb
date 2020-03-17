class WebhookController < ApplicationController
    # https://api.telegram.org/bot#{ENV['TIENDA_TOKEN']}/METHOD_NAME

    def index
        user_id = params[:message][:from][:id]
        response = Faraday.post("https://api.telegram.org/bot#{ENV['TIENDA_TOKEN']}/sendMessage", "{chat_id: #{user_id}, text: #{params[:message][:text]}}", "Content-Type" => "application/json")
        puts response.body
    end
end
