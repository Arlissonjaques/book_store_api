require 'rails_helper'

RSpec.describe Book, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price) }
  end

  describe 'assossiations' do
    it { should belong_to(:author) }
  end

end
