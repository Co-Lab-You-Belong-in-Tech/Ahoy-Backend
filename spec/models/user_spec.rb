require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(first_name: 'first', last_name: 'last', email: 'fist@last.com', password: '0123456789') }

  describe 'validation' do
    it 'default user is valid' do
      expect(subject).to be_valid
    end

    it 'requires first_name' do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it 'requires last_name' do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

    it 'requires email' do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'requires email in valid format' do
      subject.email = 'q@'
      expect(subject).to_not be_valid
    end
  end
end
