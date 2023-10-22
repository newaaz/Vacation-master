class VacationMailer < ApplicationMailer
  def vacation_created(vacation)
    @vacation = vacation
    mail to: "admin@admin.ru", subject: "Vacation created"
  end

  def vacation_changed_status(vacation)
    @vacation = vacation
    mail to: vacation.employee.email, subject: "Vacation changed status"
  end
end
