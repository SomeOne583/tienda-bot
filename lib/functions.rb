class Functions
    def self.validate_user(user_to_validate)
        # admins = Faraday.get(
        #     "https://tienda-bot.herokuapp.com/admins"
        # )
        admins = Admin.all
        admins = ApplicationController::render json: admins
        admins.gsub(/[\[\]]/, '').split(/},{/).each do
            |admin_str|
            admin_str.gsub(/[\{\}]/, '').split(',').each do
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
        case table_name
        when "admins"
            table = Admin.all
        when "appintments"
            table = Appointment.all
        when "clients"
            table = Client.all
        when "employees"
            table = Employee.all
        when "receipts"
            table = Receipt.all
        when "suppliers"
            table = Supplier.all
        end
        rows = []
        rows_as_string = ApplicationController::render json: table
        # [{"id":1,"first_name":"Jan","contact":"8115681823","created_at":"2020-03-17T18:40:23.557Z","updated_at":"2020-03-17T18:40:23.557Z"}]
        rows_as_string.gsub(/[\[\]]/, '').split(/},{/).each do
            |row|
            rows << row.gsub(/[\{\}"]/, '')
        end
        return rows.join('    ')
    end

    def self.add_to_table(table, values)
        case table
        when "admins"
            table = Admin.create(values)
        when "appintments"
            table = Appointment.create(values)
        when "clients"
            table = Client.create(values)
        when "employees"
            table = Employee.create(values)
        when "receipts"
            table = Receipt.create(values)
        when "suppliers"
            table = Supplier.create(values)
        end
        if @admin.save
            render json: @admin, status: :created, location: @admin
        else
            render json: @admin.errors, status: :unprocessable_entity
        end
    end

    def self.logger(text)
        puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
        puts text
        puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    end
end
