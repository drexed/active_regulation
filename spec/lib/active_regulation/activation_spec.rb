# frozen_string_literal: true

require 'spec_helper'

describe ActiveRegulation::Activation do
  let(:klass) { User.include(ActiveRegulation::Activation) }
  let(:user) { klass.create! }

  describe '#inactivated_at' do
    it 'to be nil' do
      expect(user.inactivated_at).to eq(nil)
    end

    it 'to be nil' do
      user.inactive!
      user.active!

      expect(user.inactivated_at).to eq(nil)
    end

    it 'to not be nil' do
      user.inactive!

      expect(user.inactivated_at).not_to eq(nil)
    end
  end

  describe '#active!' do
    it 'to be true' do
      user.active!

      expect(user.active?).to eq(true)
    end
  end

  describe '#inactive!' do
    it 'to be false' do
      user.inactive!

      expect(user.active?).to eq(false)
    end
  end

  describe '#active?' do
    it 'to be true' do
      expect(user.active?).to eq(true)
    end

    it 'to be false' do
      user.inactive!

      expect(user.active?).to eq(false)
    end
  end

  describe '#inactive?' do
    it 'to be false' do
      expect(user.inactive?).to eq(false)
    end

    it 'to be true' do
      user.inactive!

      expect(user.inactive?).to eq(true)
    end
  end

  describe '#to_activation' do
    it 'to be "Active"' do
      expect(user.to_activation).to eq('Active')
    end

    it 'to be "Inactive"' do
      user.inactive!

      expect(user.to_activation).to eq('Inactive')
    end
  end

  describe '#active' do
    it 'to be 15' do
      35.times { klass.create!(inactivated_at: Time.current) }
      15.times { klass.create!(inactivated_at: nil) }

      expect(klass.active.count).to eq(15)
    end
  end

  describe '#inactivated' do
    it 'to be 35' do
      35.times { klass.create!(inactivated_at: Time.current) }
      15.times { klass.create!(inactivated_at: nil) }

      expect(klass.inactive.count).to eq(35)
    end
  end

end
