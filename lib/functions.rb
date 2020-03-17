class Functions
    def self.validate_user(user_to_validate)
        admins = Faraday.get(
            "https://tienda-bot.herokuapp.com/admins"
        )
        puts admins.body
        admins.body.gsub(/[\[\]]/, '').split(/[\{\}]/).each do 
            |str|
            str.split(',').each do
                |a|
                if a.match(/telegram_id/)
                    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
                    puts user_to_validate
                    puts a.split(':')[1].gsub(/"/, '')
                    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
                    return true if a.split(':')[1].gsub(/"/, '') == user_to_validate
                end
            end
        end
        # admins.body.each do
        #     |admin|
        #     return true if admin['telegram_id'] == user_to_validate
        # end
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
