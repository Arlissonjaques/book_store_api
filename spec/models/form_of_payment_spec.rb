require 'rails_helper'

RSpec.describe FormOfPayment, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:type_payment) }
  end
end
