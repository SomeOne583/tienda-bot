class Functions
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
