class UpdaterTest
    def self.send_message(message_to, message)
        response = Faraday.post(
            "https://api.telegram.org/bot#{ENV['TIENDA_TOKEN']}/sendMessage",
            'chat_id': message_to,
            'text': message
        )
        return response.body
    end
end
