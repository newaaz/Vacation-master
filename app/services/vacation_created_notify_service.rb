class VacationCreatedNotifyService
  def send_notify(vacation)
    VacationMailer.vacation_created(vacation).deliver_later
  end 
end
