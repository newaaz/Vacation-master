require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'associations' do
    it { should have_many(:vacations).dependent(:destroy) }    
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end
end
