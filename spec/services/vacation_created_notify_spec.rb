require 'rails_helper'

RSpec.describe VacationCreatedNotifyService do
  let(:employee)  { create(:employee) }
  let(:vacation)  { create(:vacation, employee: employee) }

  it 'sends the employee a notice of a change in the status of his or her leave request' do  
    expect(VacationMailer).to receive(:vacation_created).with(vacation).and_call_original
    subject.send_notify(vacation)
  end
end
