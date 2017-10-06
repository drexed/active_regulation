# frozen_string_literal: true

require 'spec_helper'

describe ActiveRegulation::Quarantine do
  let(:klass) { User.include(ActiveRegulation::Quarantine) }
  let(:user) { klass.create! }

  describe '#quarantined_at' do
    it 'to be nil' do
      expect(user.quarantined_at).to eq(nil)
    end

    it 'to be nil' do
      user.quarantine!
      user.unquarantine!

      expect(user.quarantined_at).to eq(nil)
    end

    it 'to not be nil' do
      user.quarantine!

      expect(user.quarantined_at).not_to eq(nil)
    end
  end

  describe '#unquarantine!' do
    it 'to be true' do
      user.unquarantine!

      expect(user.unquarantined?).to eq(true)
    end
  end

  describe '#quarantine!' do
    it 'to be false' do
      user.quarantine!

      expect(user.unquarantined?).to eq(false)
    end
  end

  describe '#unquarantined?' do
    it 'to be true' do
      expect(user.unquarantined?).to eq(true)
    end

    it 'to be false' do
      user.quarantine!

      expect(user.unquarantined?).to eq(false)
    end
  end

  describe '#quarantined?' do
    it 'to be false' do
      expect(user.quarantined?).to eq(false)
    end

    it 'to be true' do
      user.quarantine!

      expect(user.quarantined?).to eq(true)
    end
  end

  describe '#to_suspension' do
    it 'to be "Unquarantined"' do
      expect(user.to_quarantine).to eq('Unquarantined')
    end

    it 'to be "Quarantined"' do
      user.quarantine!

      expect(user.to_quarantine).to eq('Quarantined')
    end
  end

  describe '#unquarantined' do
    it 'to be 15' do
      35.times { klass.create!(quarantined_at: Time.now) }
      15.times { klass.create!(quarantined_at: nil) }

      expect(klass.unquarantined.count).to eq(15)
    end
  end

  describe '#quarantined' do
    it 'to be 35' do
      35.times { klass.create!(quarantined_at: Time.now) }
      15.times { klass.create!(quarantined_at: nil) }

      expect(klass.quarantined.count).to eq(35)
    end
  end

end
