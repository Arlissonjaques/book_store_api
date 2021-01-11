require 'rails_helper'

RSpec.describe Order, type: :model do

  describe 'associations' do
    it { should belong_to(:client) }
    it { should belong_to(:book) }
    it { should belong_to(:form_of_payment) }
  end

end
