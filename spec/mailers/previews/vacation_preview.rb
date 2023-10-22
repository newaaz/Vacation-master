# Preview all emails at http://localhost:3000/rails/mailers/vacation
class VacationPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/vacation/vacation_created
  def vacation_created
    VacationMailer.vacation_created(Vacation.last)
  end

  # Preview this email at http://localhost:3000/rails/mailers/vacation/vacation_changed_status
  def vacation_changed_status
    VacationMailer.vacation_changed_status(Vacation.last)
  end

end
