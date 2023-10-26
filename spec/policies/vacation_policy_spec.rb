require 'rails_helper'

describe VacationPolicy do    
  subject { described_class.new(user, vacation) }

  let(:employee)       { create(:employee) }
  let(:wrong_employee) { create(:employee) }
  let(:admin)          { create(:employee, admin: true) }
  let!(:vacation)       { create(:vacation, employee: employee) }

  context "Visitor" do
    let(:user)     { nil }

    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:new) }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:update) }
  end

  context "Employee" do
    let(:user)     { employee }
    
    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:create) }

    it { is_expected.to forbid_action(:accept_vacation) }
    it { is_expected.to forbid_action(:reject_vacation) }
  end

  context "Admin" do
    let(:user)     { admin }

    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:accept_vacation) }
    it { is_expected.to permit_action(:reject_vacation) }    
  end
end

