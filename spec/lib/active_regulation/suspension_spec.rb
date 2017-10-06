# frozen_string_literal: true

require 'spec_helper'

describe ActiveRegulation::Suspension do
  let(:klass) { User.include(ActiveRegulation::Suspension) }
  let(:user) { klass.create! }

  describe '#suspended_at' do
    it 'to be nil' do
      expect(user.suspended_at).to eq(nil)
    end

    it 'to be nil' do
      user.suspend!
      user.unsuspend!

      expect(user.suspended_at).to eq(nil)
    end

    it 'to not be nil' do
      user.suspend!

      expect(user.suspended_at).not_to eq(nil)
    end
  end

  describe '#unsuspend!' do
    it 'to be true' do
      user.unsuspend!

      expect(user.unsuspended?).to eq(true)
    end
  end

  describe '#suspend!' do
    it 'to be false' do
      user.suspend!

      expect(user.unsuspended?).to eq(false)
    end
  end

  describe '#unsuspended?' do
    it 'to be true' do
      expect(user.unsuspended?).to eq(true)
    end

    it 'to be false' do
      user.suspend!

      expect(user.unsuspended?).to eq(false)
    end
  end

  describe '#suspended?' do
    it 'to be false' do
      expect(user.suspended?).to eq(false)
    end

    it 'to be true' do
      user.suspend!

      expect(user.suspended?).to eq(true)
    end
  end

  describe '#to_suspension' do
    it 'to be "Unsuspended"' do

      expect(user.to_suspension).to eq('Unsuspended')
    end

    it 'to be "Suspended"' do
      user.suspend!

      expect(user.to_suspension).to eq('Suspended')
    end
  end

  describe '#unsuspended' do
    it 'to be 15' do
      35.times { klass.create!(suspended_at: Time.current) }
      15.times { klass.create!(suspended_at: nil) }

      expect(klass.unsuspended.count).to eq(15)
    end
  end

  describe '#suspended' do
    it 'to be 35' do
      35.times { klass.create!(suspended_at: Time.current) }
      15.times { klass.create!(suspended_at: nil) }

      expect(klass.suspended.count).to eq(35)
    end
  end

end
