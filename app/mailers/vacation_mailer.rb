class VacationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.vacation_mailer.vacation_created.subject
  #
  def vacation_created
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.vacation_mailer.vacation_changed_status.subject
  #
  def vacation_changed_status
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
