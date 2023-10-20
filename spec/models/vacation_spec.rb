require 'rails_helper'

RSpec.describe Vacation, type: :model do
  describe 'associations' do
    it { should belong_to(:employee) }
  end
  
  describe 'validations' do
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date } 
  end
end
