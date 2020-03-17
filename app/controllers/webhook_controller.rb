class WebhookController < ApplicationController
    # https://api.telegram.org/bot#{ENV['TIENDA_TOKEN']}/METHOD_NAME
    
    def index
        user_id = params[:message][:from][:id]
        message = params[:message][:text]
        if message[0] == "/"
            # Is a command
            message = message[1..]
            message = Functions::get_table(message)
            send_message = Functions::send_message(user_id, message)
            puts send_message
        else
            # Is a normal message
            message = "Por favor usa uno de los comandos que tiene disponibles el bot"
            send_message = Functions::send_message(user_id, message)
            puts send_message
        end
    end
end
