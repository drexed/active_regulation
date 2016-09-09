require 'spec_helper'

describe ActiveRegulation::Quarantine do

  describe '#quarantined_at' do
    it 'to be nil' do
      user = User.create!

      expect(user.quarantined_at).to eq(nil)
    end

    it 'to be nil' do
      user = User.create!
      user.quarantine!
      user.unquarantine!

      expect(user.quarantined_at).to eq(nil)
    end

    it 'to not be nil' do
      user = User.create!
      user.quarantine!

      expect(user.quarantined_at).not_to eq(nil)
    end
  end

  describe '#unquarantine!' do
    it 'to be true' do
      user = User.create!
      user.unquarantine!

      expect(user.unquarantined?).to eq(true)
    end
  end

  describe '#quarantine!' do
    it 'to be false' do
      user = User.create!
      user.quarantine!

      expect(user.unquarantined?).to eq(false)
    end
  end

  describe '#unquarantined?' do
    it 'to be true' do
      user = User.create!

      expect(user.unquarantined?).to eq(true)
    end

    it 'to be false' do
      user = User.create!
      user.quarantine!

      expect(user.unquarantined?).to eq(false)
    end
  end

  describe '#quarantined?' do
    it 'to be false' do
      user = User.create!

      expect(user.quarantined?).to eq(false)
    end

    it 'to be true' do
      user = User.create!
      user.quarantine!

      expect(user.quarantined?).to eq(true)
    end
  end

  describe '#to_suspension' do
    it 'to be "Unquarantined"' do
      user = User.create!

      expect(user.to_quarantine).to eq('Unquarantined')
    end

    it 'to be "Quarantined"' do
      user = User.create!
      user.quarantine!

      expect(user.to_quarantine).to eq('Quarantined')
    end
  end

  describe '#unquarantined' do
    it 'to be 15' do
      35.times { User.create!(quarantined_at: Time.now) }
      15.times { User.create!(quarantined_at: nil) }

      expect(User.unquarantined.count).to eq(15)
    end
  end

  describe '#quarantined' do
    it 'to be 35' do
      35.times { User.create!(quarantined_at: Time.now) }
      15.times { User.create!(quarantined_at: nil) }

      expect(User.quarantined.count).to eq(35)
    end
  end

end
