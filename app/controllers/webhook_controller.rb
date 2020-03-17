class WebhookController < ApplicationController
    # https://api.telegram.org/bot#{ENV['TIENDA_TOKEN']}/METHOD_NAME
    updater = Updater.new
    
    def index
        user_id = params[:message][:from][:id]
        message = params[:message][:text]
        send_message = updater.send_message(user_id, message)
    end
end
