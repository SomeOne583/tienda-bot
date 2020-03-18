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
        # admins = Admin.all
        # admins = ApplicationController::render json: admins
        # admins.gsub(/[\[\]]/, '').split(/},{/).each do
        #     |admin_str|
        #     admin_str.gsub(/[\{\}]/, '').split(',').each do
        #         |admin_pairs|
        #         if admin_pairs.match?(/telegram_id/)
        #             return true if admin_pairs.split(':')[1].match?(/#{user_to_validate}/)
        #         end
        #     end
        # end
        # return false
        if Admin.find_by telegram_id: user_to_validate
            return true
        else
            return false
        end
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
            table = Admin.order(:id)
        when "appintments"
            table = Appointment.order(:id)
        when "clients"
            table = Client.order(:id)
        when "employees"
            table = Employee.order(:id)
        when "receipts"
            table = Receipt.order(:id)
        when "suppliers"
            table = Supplier.order(:id)
        end
        rows_as_string = ApplicationController::render json: table
        rows_as_string_to_rows(rows_as_string)
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
            rows_as_string_to_rows(ApplicationController::render json: row)
        else
            # ApplicationController::render json: row.errors, status: :unprocessable_entity
            rows_as_string_to_rows(ApplicationController::render json: row.errors)
        end
    end

    def self.rows_as_string_to_rows(rows_as_string)
        rows = []
        rows_as_string.gsub(/[\[\]]/, '').split(/},{/).each do
            |row|
            rows << row.gsub(/[\{\}"]/, '')
        end
        return rows.join('    ')
    end

    def self.logger(text)
        puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
        print text
        puts ""
        puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    end
end
