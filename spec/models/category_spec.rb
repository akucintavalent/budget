require 'rails_helper'

RSpec.describe Category, type: :model do
  subject do
    user = User.create(name: 'Dan', email: 'dan@test.come', password: 'password')
    Category.new(user:, name: 'fitness', icon: 'blahblah')
  end

  before { subject.save }

  it 'subject should be valid' do
    expect(subject).to be_valid
  end

  describe 'validations' do
    it 'isn\'t valid without name' do
      subject.name = ''
      expect(subject).to_not be_valid
    end

    it 'isn\'t valid with name less than 3 characters' do
      subject.name = 'ha'
      expect(subject).to_not be_valid
    end

    it 'isn\'t valid with empty icon value' do
      subject.icon = ''
      expect(subject).to_not be_valid
    end
  end
end
