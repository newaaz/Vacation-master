require 'rails_helper'

RSpec.describe VacationCreatedNotifyService do
  let(:employee)  { create(:employee) }
  let(:vacation)  { create(:vacation, employee:) }

  it 'sends the employee a notice of a change in the status of his or her leave request' do
    allow(VacationMailer).to receive(:vacation_created).with(vacation).and_call_original
    # rubocop:disable RSpec/NamedSubject
    subject.send_notify(vacation)
    # rubocop:enable RSpec/NamedSubject
    expect(VacationMailer).to have_received(:vacation_created)
  end
end
