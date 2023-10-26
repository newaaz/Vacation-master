require 'rails_helper'

RSpec.describe Vacation do
  describe 'associations' do
    it { is_expected.to belong_to(:employee) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :start_date }
    it { is_expected.to validate_presence_of :end_date }
  end
end
