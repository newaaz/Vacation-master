require "rails_helper"

RSpec.describe VacationMailer, type: :mailer do
  describe "vacation_created" do
    let(:vacation) { create(:vacation) }
    let(:mail) { VacationMailer.vacation_created(vacation) }

    it "renders the headers" do
      expect(mail.subject).to eq("Vacation created")
      expect(mail.to).to eq(["admin@admin.ru"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("New vacation created")
    end
  end

  describe "vacation_changed_status" do
    let(:vacation) { create(:vacation) }
    let(:mail) { VacationMailer.vacation_changed_status(vacation) }

    it "renders the headers" do
      expect(mail.subject).to eq("Vacation changed status")
      expect(mail.to).to eq([vacation.employee.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Your vacation request was changed status")
    end
  end
end
