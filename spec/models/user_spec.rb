require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create(name: 'Badman', email: 'meri@example.com', password: 'password') }

  # before { subject.save }

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
  end
end
