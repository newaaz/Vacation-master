def create_admin!
  Employee.create!(email: 'admin@admin.ru',
                   admin: true,password: '123456',
                   password_confirmation: '123456',
                   full_name: "Administrator")
end

def create_employee_with_vacation!
  employee = Employee.new(email: Faker::Internet.unique.email,
                          password: '123456',
                          password_confirmation: '123456',
                          full_name: Faker::Name.name)

  add_vacation_to(employee)
  employee.save
end

def add_vacation_to(employee)
  start_date = Faker::Date.forward(days: 23)
  end_date = start_date + 20.days
  status = rand(0..2)
  admined_by = (status == 0 ? nil : Employee.find_by(admin: true))

  employee.vacations.build(start_date: start_date, end_date: end_date, status: status, admined_by: admined_by)
end

Vacation.destroy_all
Employee.destroy_all
create_admin!
10.times { create_employee_with_vacation! }
