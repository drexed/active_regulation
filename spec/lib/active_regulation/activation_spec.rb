require 'spec_helper'

describe ActiveRegulation::Activation do

  describe '#inactivated_at' do
    it 'to be nil' do
      user = User.create!

      expect(user.inactivated_at).to eq(nil)
    end

    it 'to be nil' do
      user = User.create!
      user.inactive!
      user.active!

      expect(user.inactivated_at).to eq(nil)
    end

    it 'to not be nil' do
      user = User.create!
      user.inactive!

      expect(user.inactivated_at).not_to eq(nil)
    end
  end

  describe '#active!' do
    it 'to be true' do
      user = User.create!
      user.active!

      expect(user.active?).to eq(true)
    end
  end

  describe '#inactive!' do
    it 'to be false' do
      user = User.create!
      user.inactive!

      expect(user.active?).to eq(false)
    end
  end

  describe '#active?' do
    it 'to be true' do
      user = User.create!

      expect(user.active?).to eq(true)
    end

    it 'to be false' do
      user = User.create!
      user.inactive!

      expect(user.active?).to eq(false)
    end
  end

  describe '#inactive?' do
    it 'to be false' do
      user = User.create!

      expect(user.inactive?).to eq(false)
    end

    it 'to be true' do
      user = User.create!
      user.inactive!

      expect(user.inactive?).to eq(true)
    end
  end

  describe '#to_activation' do
    it 'to be "Active"' do
      user = User.create!

      expect(user.to_activation).to eq('Active')
    end

    it 'to be "Inactive"' do
      user = User.create!
      user.inactive!

      expect(user.to_activation).to eq('Inactive')
    end
  end

  describe '#active' do
    it 'to be 15' do
      35.times { User.create!(inactivated_at: Time.now) }
      15.times { User.create!(inactivated_at: nil) }

      expect(User.active.count).to eq(15)
    end
  end

  describe '#inactivated' do
    it 'to be 35' do
      35.times { User.create!(inactivated_at: Time.now) }
      15.times { User.create!(inactivated_at: nil) }

      expect(User.inactive.count).to eq(35)
    end
  end

end
