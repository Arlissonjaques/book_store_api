require 'rails_helper'

RSpec.describe Client, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:firstname) }
    it { should validate_presence_of(:lastname) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email)}
  end

  describe 'associations' do
    it { should have_many(:form_of_payments).through(:orders) }
  end

end
