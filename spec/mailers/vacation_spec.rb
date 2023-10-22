require "rails_helper"

RSpec.describe VacationMailer, type: :mailer do
  describe "vacation_created" do
    let(:mail) { VacationMailer.vacation_created }

    it "renders the headers" do
      expect(mail.subject).to eq("Vacation created")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "vacation_changed_status" do
    let(:mail) { VacationMailer.vacation_changed_status }

    it "renders the headers" do
      expect(mail.subject).to eq("Vacation changed status")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
