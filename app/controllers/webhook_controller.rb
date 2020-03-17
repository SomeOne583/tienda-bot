class WebhookController < ApplicationController
    # https://api.telegram.org/bot#{ENV['TIENDA_TOKEN']}/METHOD_NAME
    require 'updater'
    
    def index
        user_id = params[:message][:from][:id]
        message = params[:message][:text]
        send_message = Updater::send_message(user_id, message)
    end
end
