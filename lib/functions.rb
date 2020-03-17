class Functions
    def self.validate_user(user_to_validate)
        admins = Faraday.get(
            "https://tienda-bot.herokuapp.com/admins"
        )
        admins.body.gsub(/[\[\]]/, '').split(/[\{\}]/).each do 
            |admin_str|
            admin_str.split(',').each do
                |admin_pairs|
                if admin_pairs.match?(/telegram_id/)
                    return true if admin_pairs.split(':')[1].match?(/#{user_to_validate}/)
                end
            end
        end
        return false
    end

    def self.send_message(message_to, message)
        response = Faraday.post(
            "https://api.telegram.org/bot#{ENV['TIENDA_TOKEN']}/sendMessage",
            'chat_id': message_to,
            'text': message
        )
        return response.body
    end

    def self.get_table(table_name)
        # response = Faraday.get(
        #     "https://tienda-bot.herokuapp.com/#{table_name}"
        # )
        # return response.body
        @clients = Client.all
        render json: @clients
    end
end
