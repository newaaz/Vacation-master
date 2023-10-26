require 'rails_helper'

RSpec.describe Employee do
  describe 'associations' do
    it { is_expected.to have_many(:vacations).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :password }
  end
end
