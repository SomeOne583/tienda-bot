class WebhookController < ApplicationController
    # https://api.telegram.org/bot#{ENV['TIENDA_TOKEN']}/METHOD_NAME
    def validation
        user_id = params[:message][:from][:id]
        message = params[:message][:text]
        if Functions::validate_user(user_id)
            index(user_id, message)
        else
            Functions::send_message(user_id, "No estas autorizado")
        end
    end

    private

    def index(user_id, message)
        if message[0] == "/"
            # Is a command
            message = message[1..]
            if message.match?(/\s/)
                message_args = message.split(/\s/)
                table = message_args[0]
                values = message_args[1].split(/,/)
                message = Functions::add_to_table(table, values)
            else
                message = Functions::get_table(message)
            end
            send_message = Functions::send_message(user_id, message)
            Functions::logger(send_message)
        else
            # Is a normal message
            message = "Por favor usa uno de los comandos que tiene disponibles el bot"
            send_message = Functions::send_message(user_id, message)
            Functions::logger(send_message)
        end
    end
end
