class Functions
    def self.validate_user(user_to_validate)
        admins = Faraday.get(
            "https://tienda-bot.herokuapp.com/admin"
        )
        admins.body.each do
            |admin|
            return true if admin['telegram_id'] == user_to_validate
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
        response = Faraday.get(
            "https://tienda-bot.herokuapp.com/#{table_name}"
        )
        return response.body
    end
end
