class WebhookController < ApplicationController
    # https://api.telegram.org/bot#{ENV['TIENDA_TOKEN']}/METHOD_NAME
    
    def index
        user_id = params[:message][:from][:id]
        message = params[:message][:text]
        if message[0] == "/"
            # Is a command
        else
            # Is a normal message
            send_message = TelegramFunctions::send_message(user_id, message)
        end
    end
end
