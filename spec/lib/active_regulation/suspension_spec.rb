require 'spec_helper'

describe ActiveRegulation::Suspension do

  describe '#suspended_at' do
    it 'to be nil' do
      user = User.create!

      expect(user.suspended_at).to eq(nil)
    end

    it 'to be nil' do
      user = User.create!
      user.suspend!
      user.unsuspend!

      expect(user.suspended_at).to eq(nil)
    end

    it 'to not be nil' do
      user = User.create!
      user.suspend!

      expect(user.suspended_at).not_to eq(nil)
    end
  end

  describe '#unsuspend!' do
    it 'to be true' do
      user = User.create!
      user.unsuspend!

      expect(user.unsuspended?).to eq(true)
    end
  end

  describe '#suspend!' do
    it 'to be false' do
      user = User.create!
      user.suspend!

      expect(user.unsuspended?).to eq(false)
    end
  end

  describe '#unsuspended?' do
    it 'to be true' do
      user = User.create!

      expect(user.unsuspended?).to eq(true)
    end

    it 'to be false' do
      user = User.create!
      user.suspend!

      expect(user.unsuspended?).to eq(false)
    end
  end

  describe '#suspended?' do
    it 'to be false' do
      user = User.create!

      expect(user.suspended?).to eq(false)
    end

    it 'to be true' do
      user = User.create!
      user.suspend!

      expect(user.suspended?).to eq(true)
    end
  end

  describe '#to_suspension' do
    it 'to be "Unsuspended"' do
      user = User.create!

      expect(user.to_suspension).to eq('Unsuspended')
    end

    it 'to be "Suspended"' do
      user = User.create!
      user.suspend!

      expect(user.to_suspension).to eq('Suspended')
    end
  end

  describe '#unsuspended' do
    it 'to be 15' do
      35.times { User.create!(suspended_at: Time.now) }
      15.times { User.create!(suspended_at: nil) }

      expect(User.unsuspended.count).to eq(15)
    end
  end

  describe '#suspended' do
    it 'to be 35' do
      35.times { User.create!(suspended_at: Time.now) }
      15.times { User.create!(suspended_at: nil) }

      expect(User.suspended.count).to eq(35)
    end
  end

end
