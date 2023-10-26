require 'rails_helper'

describe EmployeePolicy do    
  subject { described_class.new(user, employee) }
 
  let(:profile_user) { create(:employee) }
  let(:employee)     { create(:employee) }
  let(:admin)        { create(:employee, admin: true) }

  context 'Employee can see his profile' do
    let(:user)     { :profile_user }
    let(:employee) { :profile_user }

    it { is_expected.to permit_action(:show) }
  end

  context "Visitor can't see profiles" do
    let(:user)     { nil }
    let(:employee) { :profile_user }

    it { is_expected.to forbid_action(:show) }
  end

  context "Employee can't see other profiles" do
    let(:user)     { :employee }
    let(:employee) { :profile_user }

    it { is_expected.to forbid_action(:show) }
  end

  context "Admin can't see other profiles" do
    let(:user)     { :admin }
    let(:employee) { :profile_user }

    it { is_expected.to forbid_action(:show) }
  end
end
