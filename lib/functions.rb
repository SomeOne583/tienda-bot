class Functions
    @@ADMIN_FORMAT = "{id: %i, telegram_id: '%s'}"
    @@APPOINTMENT_FORMAT = "{id: %i, initial_date: '%s', final_date: '%s', client_id: %i}"
    @@CLIENT_FORMAT = "{id: %i, first_name: '%s', contact: '%s'}"
    @@EMPLOYEE_FORMAT = "{id: %i, last_name: '%s', first_name: '%s', hours: %f, salary: %f, cellphone: '%s'}"
    @@RECEIPT_FORMAT = "{id: %i, service: '%s', cost: %f, payment_method: '%s', date: '%s', client_id: %i}"
    @@SUPPLIER_FORMAT = "{id: %i, name: '%s', contact: '%s'}"

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
            row = Admin.create(eval(@@ADMIN_FORMAT % values))
        when "appointments"
            row = Appointment.create(eval(@@APPOINTMENT_FORMAT % values))
        when "clients"
            row = Client.create(eval(@@CLIENT_FORMAT % values))
        when "employees"
            row = Employee.create(eval(@@EMPLOYEE_FORMAT % values))
        when "receipts"
            row = Receipt.create(eval(@@RECEIPT_FORMAT % values))
        when "suppliers"
            row = Supplier.create(eval(@@SUPPLIER_FORMAT % values))
        end
        if row.save
            # ApplicationController::render json: row, status: :created, location: row
            ApplicationController::render json: row
        else
            # ApplicationController::render json: row.errors, status: :unprocessable_entity
            ApplicationController::render json: row.errors
        end
    end

    def self.logger(text)
        puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
        print text
        puts ""
        puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    end
end
